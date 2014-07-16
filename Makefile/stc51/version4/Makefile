#This is the make file for the AT89S52 mcu TARGET
CC = sdcc
SRCDIR = src
INCDIR = inc
OBJDIR = obj
TARGET = $(OBJDIR)/program
#C_INC = $(wildcard $(INCDIR)/*.h)
CINCLUDE += -I./inc
CINCLUDE += -I/usr/local/share/sdcc/include
CINCLUDE += -I/usr/local/share/sdcc/include/mcs51
C_SRC = $(wildcard $(SRCDIR)/*.c)
#C_OBJ = $(patsubst %c, %rel, $(C_SRC))
C_OBJ = $(C_SRC:$(SRCDIR)/%.c=$(OBJDIR)/%.rel)

.PHONY: all
all: $(TARGET).bin
$(TARGET).bin: $(C_OBJ)
	$(CC) -mmcs51 -o $(TARGET).ihx $^
	objcopy -I ihex -O binary $(TARGET).ihx $(TARGET).bin
	@echo
	@echo "Make done"

$(C_OBJ): $(OBJDIR)/%.rel: $(SRCDIR)/%.c
	$(CC) -c -o $@ $< $(CINCLUDE)

.PHONY: tag dir
tag:
	ctags -R *

dir:
	-mkdir $(SRCDIR)
	-cp *.c $(SRCDIR)
	-mkdir $(INCDIR)
	-cp *.h $(INCDIR)
	-mkdir $(OBJDIR)
	-cp *.rel $(OBJDIR)
	-cp ~/work/my_code/Makefile/stc51/ycmconf/ycm_extra_conf.py ./.ycm_extra_conf.py
	$(MAKE) tag

.PHONY: clean clean_all
clean:
	rm -f *.bin *.ihx *.hex

clean_all: clean
	#rm -f *.o *.asm *.lst *.mem *.rst *.lk *.map *.rel *.sym
	rm -f $(OBJDIR)/*

.PHONY: download
download:
	stcflash $(TARGET).bin

.PHONY: show
show:
	@echo "test"
