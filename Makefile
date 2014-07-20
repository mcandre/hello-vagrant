CC=gcc
FLAGS=-O2 -Wall

all: hello

hello: hello.c
	$(CC) $(FLAGS) -o hello hello.c

splint:
	find . -type f -name '*.[ch]' -exec splint {} \;

puppet-lint:
	puppet-lint **/*.pp

lint: splint puppet-lint

clean:
	-rm hello
