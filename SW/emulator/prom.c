// PROM is paged ROM - not programmable ROM
// page size is 4 KB
// first 4 pages are hardwired at a000
// the fifth page at e000 is mapped by writing to address f000
// page number is given by upper byte, with LSB = 0
// when LSB = 1, PROM is mapped out switching in whatever ROMS are installed

#include <sys/mman.h>

#include "defines.h"

#define PROM_START 0xa000 /* Start address where 0 page is mapped permanently */
#define PROM_BF 0xb000 /* Address of paged memory */
#define PROM_PAGE 0x1000 /* Size of paged memory */
#define PROM_LENGTH 0x2000 /* Total length of PROM address space */ 

pdp_qmap q_prom = {
	PROM_START, PROM_LENGTH/2, prom_init, prom_read, prom_write, prom_bwrite
};

char* prom =NULL; // memory mapped prom file

d_word activePage;
char isMapped;

#define handle_error(msg) \
    do { perror(msg); exit(EXIT_FAILURE); } while (0)

    	
void writeRom(c_addr cadr, d_word* src, int bcount){
	extern unsigned long pdp_ram_map;
	unsigned long saved_ram_map = pdp_ram_map;
	pdp_ram_map = ~0l;
	d_word* data = src;
	c_addr addr;
	for (addr = cadr; addr < cadr+bcount; addr+=2)
		sc_word(addr, *data++);
	pdp_ram_map = saved_ram_map;
}

int prom_init() {
	FILE * romf;
	extern char *prompath;
	if (!prompath || !*prompath) return;

	if (prom == NULL) {
		int fd = open(prompath, O_RDONLY);
	
		if (fd == -1) {
			fprintf(stderr, "Couldn't open file %s.",prompath);
			exit(1);
		}
		
		struct stat sb;
		if (fstat(fd, &sb) == -1)           /* To obtain file size */
			handle_error("fstat");
	
		prom = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
		if (prom == MAP_FAILED)
			handle_error("mmap");
		extern pdp_qmap qmap_bk[];
		qmap_bk[1] = q_prom;
	}
	
	writeRom(PROM_START,(d_word*)prom,PROM_LENGTH);
	extern unsigned long pdp_ram_map;
	unsigned long saved_ram_map = pdp_ram_map;
	pdp_ram_map = ~0l;
	d_word* data = (d_word*)prom;
	c_addr addr= PROM_START;
	for (addr = PROM_START; addr < PROM_START+PROM_LENGTH; addr+=2)
		sc_word(addr, *data++);
	pdp_ram_map = saved_ram_map;
	
	q_prom.size = PROM_LENGTH/2;
	activePage = 0;
}

int prom_read(c_addr addr,d_word *word) {
	*word = activePage;
	return OK;
}

extern void loadBasicRom();

int prom_write(c_addr addr,d_word word) {
	if (word&1) {
		activePage = 1;
		q_prom.size = 0;
		loadBasicRom();
		return;
	}
	
	if (activePage & 1) {
		prom_init();
	}
	
	activePage = word&0xff00;
	
	writeRom(PROM_BF, (d_word*)(prom+((activePage>>8) * PROM_PAGE)), PROM_PAGE);
	
	return OK;
}

int prom_bwrite(c_addr addr, d_byte byte) {
	d_word offset = addr & 1;
	d_word word;
	if (offset)
		word = (byte << 8) | (activePage&0xff);
	else
		word = (activePage&0xff00)|byte;
	return prom_write(addr & ~1,word);
}
