### English:

# ROM-disk for BK-0010

This is software and hardware design imlementing a ROM based disk for BK-0010 computer. The unit plugs into an MPI port of the computer and on power up presents a menu of loadable software allowing user to select a program from menu and execute it.

## Software

The menu loader is located in SW directory. It can be build by issung make command from inside the directory. A GNU assembler from package GNU binutils built for pdp-11 target is required to builld the loader. The build was tested on linux with binutils v. 2.28.

Download [GNU Binutils](https://www.gnu.org/software/binutils/), extract the archive and inside the extracted directory issue the following commands:
```
mkdir build-pdp11-coff
cd build-pdp11-coff
../configure --target=pdp11-little-coff --prefix=/usr/local
make
sudo make install
```
The content to be included into the ROM payload shall be placed into durectory "content" of the project. A sub-menus will be created for sub-directories. A subdirectory with a nmae starting with dot (.) will not be shown in menu, but its content will be included in payload - such directories shall be used for overlay files that are not loaded directly.

The subdirectory "emulator" contains a modified version of BK-0010 emultor by Leonid Broukhis, that includes emulation of ROM disk hardware, suitable for testing the menu loader code. There is a command file "emulate.sh" in SW directory, that will first buidl the loader, create the ROM image and then execute the emulator (building it if necessary) with the ROM-disk device plugged into the MPI port.

## Hardware

This directory HW is for hardware designs implementing the ROM disk. Currently it contains design using 3 untis of Lattice GAL20V8 programmable device and a single PROM unit M27C800. In order to the project from source you would need ispLEVER Classic software downloadable directly from [Lattice](http://www.latticesemi.com/).

The source for programable logic is in *.abl files, the loadable JEDEC programming is in *.jed files. 

The connection list is located in file conn.txt where each line lists a single signal with pins of each of the devices that shall be connected to the signal.

Note that this design have not yet been verified with real hardware.

### Русский:

# ROM-Диск для компьютера BK-0010

Здесь содержится разработка програм и железа ROM-диска для домашнего компьютера БК-0010. Разрабатываемое устройство подключается к компьютеру через разьём МПИ, при включениии компьютера выводит на экран меню програм, содержащихся на ROM-диске, и позволяет пользователю выбрать и запустить содержащиеся программы.

## Програмное обеспечение устройства

Исходники загрузчика меню находятся в диретории SW. Программа может быть собрана командой make запущенной в этой директории. Для сборки требуется доступ к ассемблеру GNU из пакета GNU Binutils собранного для платформы pdp-11. Сборка была протестирована под ОС линукс с установленными Binutils версии 2.28.

Для установки, сгрузите архив исходников [GNU Binutils](https://www.gnu.org/software/binutils/), разархивируйте, i произведите следующие команды в полученной директории:
```
mkdir build-pdp11-coff
cd build-pdp11-coff
../configure --target=pdp11-little-coff --prefix=/usr/local
make
sudo make install
```
Программы, которые будут включены в образ диска, следует поместить в директорию "content". Под-директории показываются на экране как меню. Директории, имена которых начинаются с символа точка (.) не будут включены в систему меню, но содержимое этих директорий будет загружено в образ диска. Назначение таких директорий - содержать оверлеи и файлы данных, которые не загружаются сами по себе, но нужны для головных програм.

В под-директории "emulator" содержатся модифицированные исходники эмулятора БК от Леонида Брухиса, поддерживающие эмуляцию железа ROM-диска и потому пригодные для тестирования и отладки загрузчика меню. В директории SW есть командный файл "emulate.sh", запуск которого приводит к сборке программы меню-загрузчика, созданию образа ROM-диска, запуска эмулятора (который также будет собран при необходимости) в конфигурации с подключённым ROM-диском.

## Железо

Директория HW существует для разработок оборудования работающего как ROM-диск. В данный момент имеется единственная разработка на основе 3-х микросхем GAL20V8 компании Lattice и одной микросхемы ПЗУ M27C800. Для того чтобы собрать загружаемые файлы из исходников этой разработки необходима установка пакета ispLEVER Classic который можно сгрузить бесплатно с сайта компании [Lattice](http://www.latticesemi.com/).

Исходники програмируемой логики находятся в файлах *.abl, загружаемые модули в формате JEDEC содержатся в файлах *.jed.

Список электроных цепей, образующих устройство, содержится в файле conn.txt. Каждая строка этого файла соответствует сигналу, в каждой колонке указаны ножки соответствующей микросхемы (и разъёна МПИ), которые должны быть подсоединены к данному сигналы.

Внимание: на данное время разработка не была протестирована на собранном устройстве.
