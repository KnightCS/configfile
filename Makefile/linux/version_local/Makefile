#This is a make file for project in linux.
#Author:KnightCS(chenshuomailbox@gmail.com)

#dir
SRC_DIR = .
INC_DIR = .
OBJ_DIR = obj

CC = gcc
CFLAGS = -g
CINCLUDE = -I./$(INC_DIR)

#file
TARGET = program
C_SRC = $(wildcard $(SRC_DIR)/*.c)
C_OBJ = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(C_SRC))
#C_OBJ = $(C_SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

.PHONY:all
all:$(TARGET)
$(TARGET):$(C_OBJ)
	$(CC) -o $@ $^
	@echo
	@echo "Make Done"

$(C_OBJ):$(OBJ_DIR)/%.o:$(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $< $(CINCLUDE)

.PHONY:clean
clean:
	-rm -f $(OBJ_DIR)/*
	-rm -f $(TARGET)

.PHONY:dir tag
dir:
	-mkdir $(SRC_DIR)
	-mkdir $(INC_DIR)
	-mkdir $(OBJ_DIR)
	$(MAKE) tag

tag:
	ctags -R *

.PHONY:show
show:
