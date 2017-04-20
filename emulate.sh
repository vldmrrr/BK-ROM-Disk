#!/bin/sh
if test ! -f emulator/bk
then
	make -C emulator
fi
if test ! -f ROM.bin
then
	make
fi

BK_PATH=./emulator/Rom emulator/bk -c -1 -P ROM.bin

