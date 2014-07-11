#This is the make file for the AT89S52 mcu TARGET
CC = sdcc
TARGET = program
C_HEAD = $(wildcard *.h)
C_SRC = $(wildcard *.c)
C_OBJ = $(patsubst %c, %rel, $(C_SRC))

.PHONY: all clean clean_all download

all: $(TARGET).bin
$(TARGET).bin: $(C_OBJ)
	$(CC) -mmcs51 -o $(TARGET).ihx $^
	objcopy -I ihex -O binary $(TARGET).ihx $(TARGET).bin
	make clean

$(C_OBJ): %.rel: %.c $(C_HEAD)
	$(CC) -c -o $@ $<

clean:
	rm -f *.o *.asm *.lst *.mem *.rst *.lk *.map *.rel *.sym

clean_all: clean
	rm -f *.bin *.ihx *.hex

download:
	stcflash $(TARGET).bin
