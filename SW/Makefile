ASM=pdp11-aout-as
LD=pdp11-aout-ld

SOURCES=menu.mac
OBJ = $(patsubst %.mac,%.o,$(SOURCES))

%.o: %.mac
	$(ASM) -alsm=$(patsubst %.o,%.ls,$@) -o $@ $<

ROM.bin: menuloader packcontent.py megalz
	#dd if=/dev/null of=menuloader bs=1 count=0 seek=24576
	python ./packcontent.py
	
menuloader: $(OBJ) Linker.Script Makefile
	$(LD) -T Linker.Script $< -o $@ -Map=$@.map

.PHONY: megalz

megalz:
	$(MAKE) -C MegaLZ/Unices
	mv MegaLZ/Unices/megalz .

