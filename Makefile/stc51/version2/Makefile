#This is the make file for the AT89S52 mcu TARGET
CC = sdcc
OBJDIR = obj
TARGET = $(OBJDIR)/program
C_HEAD = $(wildcard *.h)
C_SRC = $(wildcard *.c)
#C_OBJ = $(patsubst %c, %rel, $(C_SRC))
C_OBJ = $(C_SRC:%.c=$(OBJDIR)/%.rel)

.PHONY: all dir clean clean_all install download

all: dir $(TARGET).bin install
$(TARGET).bin: $(C_OBJ)
	$(CC) -mmcs51 -o $(TARGET).ihx $^
	objcopy -I ihex -O binary $(TARGET).ihx $(TARGET).bin

$(C_OBJ): $(OBJDIR)/%.rel: %.c $(C_HEAD)
	$(CC) -c -o $@ $<

dir:
	-mkdir $(OBJDIR)

clean:
	rm -f *.bin *.ihx *.hex

clean_all: clean
	#rm -f *.o *.asm *.lst *.mem *.rst *.lk *.map *.rel *.sym
	rm -f $(OBJDIR)/*

install:
	cp $(TARGET).bin .

download:
	stcflash $(TARGET).bin
