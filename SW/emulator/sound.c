#include "defines.h"
#include <stdio.h>
#include <SDL/SDL.h>
#include <SDL/SDL_thread.h>
#include <SDL/SDL_mutex.h>
#include <linux/soundcard.h>
#include <libintl.h>
#define _(String) gettext (String)

#define SOUND_EXPONENT	(8+io_sound_freq/20000)
#define SOUND_BUFSIZE   (1<<SOUND_EXPONENT)		/* about 1/43 sec */
#define SOUND_FRAGMENTS	3
#define MAX_SOUND_AGE	~0	/* always play */ 

unsigned io_max_sound_age = MAX_SOUND_AGE;
unsigned io_sound_age = MAX_SOUND_AGE;	/* in io_sound_pace's since last change */
unsigned io_sound_bufsize,
	io_sound_freq = 11025,
	io_sound_pace;
double io_sound_count;
extern unsigned io_sound_val, covox_age;
extern unsigned char covox_val;
extern flag_t nflag, fullspeed;

typedef struct {
	short * buf;
	unsigned int ptr;
	SDL_mutex * lock;

} sound_buf_t;

sound_buf_t sound_buf[2];

int cur_buf;

int io_sound_fd = -1;

#ifdef THREADED
int write_buffer(void * dummy)
{
    while (1) {
	SDL_mutexP(sound_buf[0].lock);
	if (io_sound_fd == -1) return 0;
	write(io_sound_fd, sound_buf[0].buf, sound_buf[0].ptr*sizeof(short));
	sound_buf[0].ptr = 0;
	SDL_mutexV(sound_buf[0].lock);
	SDL_mutexP(sound_buf[1].lock);
	if (io_sound_fd == -1) return 0;
	write(io_sound_fd, sound_buf[1].buf, sound_buf[1].ptr*sizeof(short));
	sound_buf[1].ptr = 0;
	SDL_mutexV(sound_buf[1].lock);
    }
}
#endif

/* Called after every instruction */
sound_flush() {
	if (fullspeed && io_sound_age >= io_max_sound_age && covox_age >= io_max_sound_age) {
		/* No change in sound bit for a while, nothing to play,
		 * and drop whatever is in the buffer, 1/21 sec does not
		 * matter.
		 */
		if (sound_buf[cur_buf].ptr != 0) {
			write(io_sound_fd, sound_buf[cur_buf].buf, sound_buf[cur_buf].ptr * sizeof(short));
			ioctl(io_sound_fd, SNDCTL_DSP_POST);
			sound_buf[cur_buf].ptr = 0;
			cur_buf = !cur_buf;
		}
		return;
	}
	while (ticks >= io_sound_count) {
		short * p =
			&sound_buf[cur_buf].buf[sound_buf[cur_buf].ptr++];
		if (io_sound_age < 1000)
			*p = io_sound_val + covox_val << 4;
		else
			*p = (covox_val << 4) + synth_next();
		io_sound_count += io_sound_pace;
		io_sound_age++;
		covox_age++;
		if (io_sound_bufsize == sound_buf[cur_buf].ptr ||
			io_sound_age == io_max_sound_age) {
#ifdef THREADED
			/* lock the other buffer first */
			SDL_mutexP(sound_buf[!cur_buf].lock);
			/* release current buffer to be played */
			SDL_mutexV(sound_buf[cur_buf].lock);
#else
			write(io_sound_fd, sound_buf[cur_buf].buf, sound_buf[cur_buf].ptr * sizeof(short));
			sound_buf[cur_buf].ptr = 0;
#endif
			cur_buf = !cur_buf;
			
		}
	}
}

void sound_finish() {
	io_sound_fd = -1;
	/* release the write thread so it can terminate */
	SDL_mutexV(sound_buf[cur_buf].lock); 
}

sound_init() {
	static init_done = 0;
	int iarg;
	if (!nflag)
		return;
	if (fullspeed) {
		io_max_sound_age = SOUND_FRAGMENTS * SOUND_BUFSIZE;
		/* otherwise UINT_MAX */
	}
	if (init_done) {
		sound_buf[cur_buf].ptr = 0;
		io_sound_age = io_max_sound_age;
		return;
	}
	fprintf(stderr, _("sound_init called\n"));

	fprintf(stderr, _("Opening audio... "));
	io_sound_fd = open("/dev/dsp", O_WRONLY);
	if (-1 != io_sound_fd) {
		fprintf(stderr, _("Done.\n"));
	} else {
		perror("/dev/dsp");
		nflag = 0;
		return;
	}
	
	int fmt = 16;
	if (-1 == ioctl(io_sound_fd, SNDCTL_DSP_SETFMT, &fmt)) {
		perror(_("Setting 16-bit sound failed"));
	}
	fmt = 1;
	if (-1 == ioctl(io_sound_fd, SNDCTL_DSP_CHANNELS, &fmt)) {
		perror(_("Setting mono sound failed"));
	}

	/* Setting desired frequency */
	int sf = io_sound_freq;
	ioctl(io_sound_fd, SNDCTL_DSP_SPEED, &io_sound_freq);
	if (io_sound_freq != sf) {
		fprintf(stderr, _("Warning: %s doesn't support default sample rate of %d (set to %d)\n"), "/dev/dsp", sf, io_sound_freq);
	}
	io_sound_pace = TICK_RATE/io_sound_freq;

	/* Setting desired buffering parameters: 3 buffers, 1 Kb each */
	iarg = (SOUND_FRAGMENTS << 16) | SOUND_EXPONENT;
	if (ioctl(io_sound_fd, SNDCTL_DSP_SETFRAGMENT, &iarg) == -1) {
		perror(_("/dev/dsp: setfragment failed"));
		exit(1);
	}

	/* Checking what we've got */
	if (ioctl(io_sound_fd, SNDCTL_DSP_GETBLKSIZE, &io_sound_bufsize) == -1) {
		perror(_("/dev/dsp: getbksize failed"));
		exit(1);
	}
	if (io_sound_bufsize != SOUND_BUFSIZE) {
		fprintf(stderr, _("Warning: asked for sound delay 1/%d sec, got 1/%d sec\n"),
		io_sound_freq/SOUND_BUFSIZE, io_sound_freq/io_sound_bufsize);

		/* We may want to rerequest more fragments by closing
		 * /dev/dsp and restarting sound_init(), but let's hope
		 * that current computers are fast enough.
		 */
		if (io_sound_freq/io_sound_bufsize > 100) {
			fprintf(stderr, _("Warning: sound quality may be low\n"));
		}
	}
	sound_buf[0].ptr = sound_buf[1].ptr = 0;
	sound_buf[0].buf = malloc(io_sound_bufsize * sizeof(short));
	sound_buf[1].buf = malloc(io_sound_bufsize * sizeof(short));
	if (!sound_buf[1].buf) {
		fprintf(stderr, _("Failed to allocate sound buffers\n"));
		exit(1);
	}
#ifdef THREADED
	sound_buf[0].lock = SDL_CreateMutex();
	sound_buf[1].lock = SDL_CreateMutex();
	SDL_mutexP(sound_buf[0].lock);
	SDL_CreateThread(write_buffer, 0); /* will immediately lock */
	atexit(sound_finish);
#endif
	init_done = 1;
}
