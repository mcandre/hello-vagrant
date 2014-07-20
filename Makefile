CC=gcc
FLAGS=-O2 -Wall

all: hello

hello: hello.c
	$(CC) $(FLAGS) -o hello hello.c

splint:
	find . -type f -name '*.[ch]' -exec splint {} \;

puppet-lint:
	find . -type f -name '*.pp' -exec puppet-lint {} \;

lint: splint puppet-lint

clean:
	-rm hello
