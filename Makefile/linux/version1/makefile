#This is a makefile, witch will creat *.i *.s *.o file
program: main.o
	gcc main.o -o program

main.o: main.s
	gcc -c main.c -o main.o -Wall

main.s: main.i
	gcc -S main.c -o main.s

main.i: main.c
	gcc -E main.c -o main.i

.PHONY:clean
clean:
	-rm -r -f program *.i *.s *.o
