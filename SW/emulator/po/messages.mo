��    �      �  �   �	           	          ;     H  h   a  C   �  (        7  $   L  &   q  "   �  &   �  )   �  /     <   <  <   y  <   �  <   �  7   0  '   h  '   �     �     �     �  "        1     M  7   k     �     �     �     �  /        8  E   L     �     �  9   �     �     	  $        D  #   ^  )   �  E   �     �  1        B     X     s      �     �     �  ,   �  )  �     !     .     :     R     `     w  )   �     �     �     �     �          )     9     ?  "   F     i     w     �     �  !   �     �     �     �          $      B  %   c     �     �     �     �     �  D        P     ]     k  
   r     }     �     �     �     �     �     �     �     �       $   $     I  $   e  (   �     �      �  &   �       .   *  "   Y      |     �     �     �     �     �     �       5   -  8   c     �     �     �  )   �       B   "  6   e  "   �  '   �  ,   �          *     2     H     g     �     �     �     �     �          <     [     u     �     �     �     �     �     
   )     -   A!  %   o!     �!  (   �!  �   �!     �"  l   	#  *   v#  R   �#  =   �#  $   2$  :   W$  ?   �$  M   �$  \    %  \   }%  \   �%  \   7&  p   �&  G   '  O   M'  '   �'  >   �'  7   (  `   <(  .   �(  4   �(  p   )  /   r)  )   �)  8   �)  0   *  m   6*  <   �*  �   �*  2   f+  +   �+  x   �+     >,  Q   R,  8   �,  8   �,  H   -  2   _-  s   �-  G   .  O   N.  @   �.  3   �.  5   /  c   I/  	   �/     �/  ?   �/  %  0     82      W2  4   x2     �2  G   �2  )   3  a   03  (   �3  +   �3  1   �3  .   4  C   H4  /   �4     �4     �4  B   �4     (5      85     Y5     p5  :   ~5  -   �5  "   �5     
6     %6  Q   B6  B   �6  p   �6  7   H7  7   �7  ;   �7      �7  ,   8  w   B8     �8     �8     �8     �8  3   9     ?9     P9  A   _9     �9  1   �9  ,   �9     :     ':  8   ::  Z   s:  ;   �:  Z   
;  X   e;     �;  Q   �;  G   #<  O   k<  M   �<  e   	=  6   o=     �=     �=  "   �=  +   �=     %>  W   5>  X   �>  _   �>  �   F?  )   �?  4   �?  4   2@  �   g@     �@     A  �   �A  R   B  v   `B  B   �B  ,   C     GC  +   TC  3   �C  3   �C  6   �C  +   D  6   KD  6   �D  6   �D  6   �D  9   'E  .   aE  5   �E  )   �E  G   �E     8F  '   QF  A   yF     �F         H       v   <   T       1           �           *   �   /      E   ,               ^   �   2   =              O       )   w       '   8   :   o                          �   6       n   �       �       -          B       c   �   �       3   	           ~           7   l              _   r   a   u   P   (   �           �   V   {   h   �   Q   0       W   �   �   R   |   @   ]   e          Y   �   `   y         M   �   �       C   �   !   F   4          S       L   I   N       .           j         +   x                t         U   �       �   �   G       Z       �   >   \      b       p              [      �   $   
       �   s   g   "   d   f   D       }   �           ;   �   %   m   &       9   #   5             A          z   i   k      X         q      ?      K          �      J   �            
Double trap @ %06o.
 
Emulator shell commands:

 
Examples:.
 
Execution interrupted.
 
The default ROM files are stored in
%s or the directory specified
by the environment variable BK_PATH.
 
Type 'MO' to quit BASIC VILNIUS 1986 and get the MONITOR prompt.

 
Type 'S160000' to boot from floppy A:.
 
Unexpected return.
    'bk -R./BK.ROM' - Use custom ROM
    'bk -a -n -f'   - Developer's mode
    'bk -c -D'      - Gaming mode

    -0        BK-0010 (Focal and tape)
    -1        BK-0010.01 (Basic and tape)
    -2        BK-0010.01+FDD (No basic, floppy)
    -A<file>  A: floppy image file or device (instead of %s)
    -B<file>  B: floppy image file or device (instead of %s)
    -C<file>  C: floppy image file or device (instead of %s)
    -D<file>  D: floppy image file or device (instead of %s)
    -R<file>  Specify an alternative ROM file @ 120000.
    -T        Disable reading from tape
    -a        Do not boot automatically
    -c        Color mode
    -d        Double size mode
    -f        Full speed mode
    -l<path>  Set printer pathname
    -m        Disable mouse
    -n        Disable speaker
    -r<file>  Specify an alternative ROM file @ 160000.
    -t        Trace mode
  '?' - Emulator help
  'T' - Run built-in tests.

  'b' - Set a breakpoint
  'd' - Dump memory ('d start end' or 'd start'
  'e' - Edit memory
  'g' - Start execution ('g' or 'g 100000' boots the BK0010 computer)
  'h' - Command help
  'i' - Fire an interrupt
  'l' - Load file ('l filename.bin' loads specified file)
  'q' - Quit

  'r' - Register dump
  's' - Execute a single instruction
  't' - Toggle trace flag
  F12 - Load a file into BK memory

  Left Super+F11 - Reset emulated machine
  ScrollLock - Toggle video mode (B/W, Color) and doublesized display
  pc=%06o, last branch @ %06o
 %s block %d (%d words) from drive %d @ addr %06o
 %s will be read only
 /dev/dsp: getbksize failed /dev/dsp: setfragment failed Asked for strobe in Idle state?
 BK-0010 BK-0010 Emulator BK-0010 speed: %.5g instructions per second
 BK0010 MONITOR (the OS) commands:

 'A' to 'K' - Quit MONITOR.
 'M' - Read from tape. Press 'Enter' and type in the filename of
       the desired .bin snapshot. Wait until the data loads into
       the memory or use F12 instead.
 'S' - Start execution. You can specify an address to start from.
 Bad address
 Bad vector
 Block number too large
 Calling (%s)
 Can't lock screen: %s
 Checksum = %06o
 Checksum error: read %06o, computed %06o
 Checksum will be %06o
 Closed maketape
 Could not initialize SDL: %s.
 Couldn't open file.
 Couldn't set up video: %s
 Disk not ready
 Done
 Done.
 Done.
Last filled address is %06o
 ERROR code %c Emulator window hotkeys:

 End of tape
 Failed
 Failed to allocate sound buffers
 False header marker
 File address will be %o
 File length will be %o
 File name: <% .16s>
 Found start tune-up sequence
 Illegal byte write address %06o: Illegal inst. %s, last branch @ %06o
 Illegal read address %06o: Illegal write address %06o: Incomplete or damaged file.
 Initializing SDL.
 Instructions executed: %d
 Invalid command, use d, e, g, r, s, t, l, i, b, q, ? and h for help
 LOAD called
 Loading %s... NAME?  No memory
 No timing for instr %06o
 OFF ON Opening audio...  Polarity set to %d
 Possible start addresses:   Read failure @ %06o
 Reading Reading %06o
 Reading %s into %06o...  Reading 177130 @%06o, returned %06o
 Reading 177130, returned 0
 Reading 177132 @%06o, returned %06o
 Reading 177132 when no I/O is progress?
 SDL initialized.
 Setting unknown timer mode bits
 Simulating reading array with tune-up
 Simulating tune-up sequence
 Simulation rate: %.5g instructions per second
 Skipped %d strobes to find marker
 Start address %06o, length %06o
 Tape %s
 Tape ended
 Tape position %0o
 The BASIC ROM is disabled.

 Threshold set to %d
 Too long (%d), assuming 1
 Too short (%d) assuming 0
 Type 'P M' to quit FOCAL and get the MONITOR prompt.
 Type 'P T' to enter the test mode. 1-5 selects a test.

 Unexpected event %d
 Unknown BK model. Bailing out.
 Usage: %s [options]
 Usage: maketape BK_NAME infile > outfile
 WAIT instruction
 Warning: %s doesn't support default sample rate of %d (set to %d)
 Warning: asked for sound delay 1/%d sec, got 1/%d sec
 Warning: sound quality may be low
 Welcome to "Elektronika BK" emulator!

 Will read unix file <%s> under BK name <%s>
 Write failure @ %06o
 Writing Writing %03o to %06o
 Writing %03o to timer counter
 Writing %06o to timer counter
 Writing 177130, data %06o
 Writing 177132, data %06o
 Writing byte 177130, data %03o
 Writing byte 177131, data %03o
 Writing byte 177132, data %03o
 Writing byte 177133, data %03o
 Writing byte to ROM addr %06o: Writing to ROM addr %06o: Writing to kbd data register,  checksum = %06o
 ev_register(): no free events
 exec=%d pc=%06o ir=%06o
 readtape open successful
 sound_init called
 write error
 Project-Id-Version: bk 0.1
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2003-09-22 23:15+0400
PO-Revision-Date: 2003-09-22 23:32+0400
Last-Translator: slava <sdiconov@mail.ru>
Language-Team: Russian <ru@li.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit 
Двойной trap по адресу %06o.
 
Команды эмулятора:

 
Примеры:.
 
Выполнение прервано.
 
Стандартные файлы прошивок ПЗУ находятся
в %s или в каталоге, указанном
в переменной окружения BK_PATH.
 
Введите команду 'MO' чтобы выйти из среды БЕЙСИК ВИЛЬНЮС 1986 в МОНИТОР.

 
Введите команду 'S160000' чтобы начать загрузку с дисковода A:.
 
Неожиданное значение.
    'bk -R./BK.ROM' - Загрузка нестандартной прошивки
    'bk -a -n -f'   - Для программирования
    'bk -c -D'      - Для игр

    -0        БК-0010 (Фокал, магнитофон)
    -1        БК-0010.01 (Бейсик, магнитофон)
    -2        БК-0010.01+НГМД (Нет бейсика, дисковод)
    -A<файл>  Образ дискеты или устройство A: (вместо %s)
    -B<файл>  Образ дискеты или устройство B: (вместо %s)
    -C<файл>  Образ дискеты или устройство C: (вместо %s)
    -D<файл>  Образ дискеты или устройство D: (вместо %s)
    -R<файл>  Загрузить пользовательскую прошивку по адресу 120000.
    -T        Запретить чтение с магнитофона
    -a        Отключить автоматический запуск БК
    -c        Цветной режим
    -d        Увеличить экран в два раза
    -f        Максимальная скорость
    -l<путь>  Путь размещения файла вывода с принтера БК
    -m        Отключить мышь БК
    -n        Отключить динамик БК
    -r<файл>  Загрузить пользовательскую прошивку по адресу 160000.
    -t        Режим трассировки
  '?' - Справка эмулятора
  'T' - Запуск встроенных тестов.

  'b' - Задать точку останова
  'd' - Запись содержимого памяти ('d начало конец' или 'd начало'
  'e' - Редактирование ячеек памяти
  'g' - Запуск на выполнение (команда 'g' или 'g 100000' соответствует запуску БК)
  'h' - Обзор команд эмулятора
  'i' - Вызвать прерывание
  'l' - Загрузить файл ('l файл.bin' вызывает загрузку указанного файла)
  'q' - Выход

  'r' - Вывод содержимого регистров процессора
  's' - Выполнить одну инструкцию
  't' - Изменить флаг трассировки
  F12 - Быстрая загрузка файла в память БК

  Левый Super+F11 - Перезапуск БК
  ScrollLock - Перебор видеорежимов (ч/б, цвет) и увеличение в два раза
  pc=%06o, последнее ветвление по адресу %06o
 %s блок %d (%d слов) с устройства %d по адресу %06o
 %s будет доступен только для чтения
 /dev/dsp: ошибка процедуры getbksize /dev/dsp: ошибка процедуры setfragment Запрос стробирующего импульса в состоянии остановки?
 БК-0010 Эмулятор БК-0010 Скорость БК: %.5g операций в секунду
 Команды МОНИТОРА БК-0010:

 'A' - 'K' - Выход из МОНИТОРА.
 'M' - Чтение с магнитофона. Нажмите 'Ввод' и введите имя файла
       в формате .bin. Подождите пока данные загрузятся в память или
       воспользуйтесь функцией быстрой загрузки по клавише F12.
 'S' - Запуск программы. После команды можно указывать адрес запуска.
 Ошибочный адрес
 Ошибочный вектор
 Слишком большой номер блока
 Вызов (%s)
 Невозможно получить доступ к экрану: %s
 Контрольная сумма = %06o
 Ошибка контрольной суммы: считанная %06o, расчётная %06o
 Контрольная сумма: %06o
 Завершение работы maketape
 Ошибка инициализации SDL: %s.
 Невозможно открыть файл.
 Невозможно установить видеорежим: %s
 Нет готовности дисковода
 Завершено
 Завершено.
 Завершено.
Конечный адрес данных %06o
 ОШИБКА %c Горячие клавиши:

 Конец ленты
 Ошибка
 Ошибка выделения буферов звука
 Ложный маркер заголовка
 Начальный адрес: %o
 Длина файла: %o
 Имя файла: <% .16s>
 Обнаружена настроечная последовательность
 Недопустимый адрес записи байта: %06o; Недопустимая инструкция. %s, последнее ветвление по адресу %06o
 Недопустимый адрес чтения: %06o; Недопустимый адрес записи: %06o; Повреждённый или неполный файл.
 Инициализация SDL.
 Выполнено инструкций: %d
 Неизвестная команда, введите d, e, g, r, s, t, l, i, b, q. ? и h - вызов справки
 ЗАГРУЗКА файла
 Загрузка %s... ИМЯ? Нет памяти
 Нет такта для инструкции %06o
 ВЫКЛЮЧЕН ВКЛЮЧЕН Открытие устройства вывода звука...  Полярность: %d
 Возможные адреса запуска:   Ошибка чтения адреса %06o
 Чтение Чтение %06o
 Чтение %s в память с адреса %06o...  Чтение регистра 177130 содержащего %06o, результат %06o
 Чтение регистра 177130, результат 0
 Чтение регистра 177132 содержащего %06o, результат %06o
 Чтение регистра 177132 без активного ввода/вывода?
 Запуск SDL.
 Неизвестное сочетание битов режима таймера
 Симуляция чтения данных с подстройкой
 Симуляция настроечной последовательности
 Скорость эмулятора: %.5g операций в секунду
 Пропущено %d стробирующих импульсов при поиске маркера
 Начальный адрес: %06o, длина: %06o
 Магнитофон %s
 Конец ленты
 Положение ленты %0o
 ПЗУ БЕЙСИКА отключено.

 Порог: %d
 Слишком длинный файл (%d), предполагаемая длина 1
 Слишком короткий файл (%d) предполагаемая длина 0
 Введите команду 'P M' чтобы выйти из ФОКАЛА в МОНИТОР.
 Введите команду 'P T' чтобы запустить встроенные тесты. Цифры 1-5 - выбор теста.

 Неожиданное событие %d
 Неизвестная модель БК. Стоп.
 Использование: %s [параметры]
 Использование: maketape [имя входного файла] (в формате БК) > [выходной файл]
 Инструкция WAIT
 Внимание: %s не поддерживает стандартную частоту %d (установленную в %d)
 Внимание: запрошена задержка проигрывания звука 1/%d сек., результат 1/%d сек.
 Внимание: возможно ухудшение качества звука
 Добро пожаловать в эмулятор компьютеров серии "Электроника БК"!

 Чтение файла Юникс <%s> с БК именем <%s>
 Ошибка записи адреса %06o
 Запись Запись в область %03o - %06o
 Запись %03o в счётчик таймера
 Запись %06o в счётчик таймера
 Запись байта %06o в регистр 177130
 Запись %06o в регистр 177132
 Запись байта %03o в регистр 177130
 Запись байта %03o в регистр 177131
 Запись байта %03o в регистр 177132
 Запись байта %03o в регистр 177133
 Запись байта в ПЗУ по адресу %06o: Запись в ПЗУ по адресу %06o: Запись в регистр клавиатуры,  Контрольная сумма = %06o
 ev_register(): нет свободного буфера событий
 exec=%d pc=%06o ir=%06o
 Успешный запуск readtape
 Инициализация звуковой подсистемы
 Ошибка записи
 