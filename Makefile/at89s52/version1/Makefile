#This is the make file for the AT89S52 mcu TARGET
CC = sdcc
SRCDIR = src
INCDIR = inc
OBJDIR = obj
TARGET = $(OBJDIR)/program
#C_INC = $(wildcard $(INCDIR)/*.h)
CINCLUDE = -I./inc
C_SRC = $(wildcard $(SRCDIR)/*.c)
#C_OBJ = $(patsubst %c, %rel, $(C_SRC))
C_OBJ = $(C_SRC:$(SRCDIR)/%.c=$(OBJDIR)/%.rel)

.PHONY: all dir clean clean_all install download show

all: dir $(TARGET).bin
$(TARGET).bin: $(C_OBJ)
	$(CC) -mmcs51 -o $(TARGET).ihx $^
	objcopy -I ihex -O binary $(TARGET).ihx $(TARGET).bin
	@echo
	@echo "Make done"

$(C_OBJ): $(OBJDIR)/%.rel: $(SRCDIR)/%.c
	$(CC) -c -o $@ $< $(CINCLUDE)

dir:
	-mkdir $(SRCDIR)
	-mkdir $(INCDIR)
	-mkdir $(OBJDIR)

clean:
	rm -f *.bin *.ihx *.hex

clean_all: clean
	#rm -f *.o *.asm *.lst *.mem *.rst *.lk *.map *.rel *.sym
	rm -f $(OBJDIR)/*

download:
	avrdude -p 8052 -c usbasp -e -U flash:w:$(TARGET).ihx

show:
	@echo "test"
