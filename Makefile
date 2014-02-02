CC=gcc
FLAGS=-O2 -Wall

all: hello

hello: hello.c
	$(CC) $(FLAGS) -o hello hello.c

lint:
	splint *.c *.h

clean:
	-rm hello
