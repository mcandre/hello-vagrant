CC=gcc
FLAGS=-O2 -Wall

BIN=bin/hello

all: $(BIN)

$(BIN): hello.c
	mkdir -p bin/
	$(CC) $(FLAGS) -o $(BIN) hello.c

splint:
	find . -type f -name '*.[ch]' -exec splint {} \;

puppet-lint:
	find . -type f -name '*.pp' -exec puppet-lint {} \;

lint: splint puppet-lint

cucumber:
	bundle exec cucumber

clean:
	-rm -rf bin/
