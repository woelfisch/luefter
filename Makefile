AS=avr-gcc
ASFLAGS=-mmcu=attiny45 -I/opt/cross/avr/avr/include/ -nostartfiles -nodefaultlibs
LD=avr-ld
LDFLAGS= -mavr25

all: luefter.elf luefter.hex

flash: luefter.hex
	# -D		do not erase
	# -p t45	ATTiny45
	# -c usbasp	USBasp-Programmer
	# -U ...	what to do...
	# -e		erase
	# -u		do not verify fuses
	
	# flash erase
	avrdude -e -u -p t45 -c usbasp
	# flash program
	avrdude -D -p t45 -c usbasp -U flash:w:luefter.hex

disasm: 
	avr-objdump -d luefter.elf

clean:
	rm -f *.o *.elf *.hex 2>/dev/null

%.hex: %.elf
	avr-objcopy -j .text -j .data -j .eeprom -O ihex $< $@
%.elf: %.o
	$(LD) $(LDFLAGS) -o $@ $<
.S.o:
	$(AS) $(ASFLAGS) -o $@ $<

