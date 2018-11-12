CC=gcc
FLAGS=-O2 -Wall

BIN=bin/hello

all: $(BIN)

$(BIN): hello.c
	@mkdir -p bin
	@$(CC) $(FLAGS) -o $(BIN) hello.c

splint:
	@find . -type f -name '*.[ch]' -exec splint {} \;

puppet-lint:
	@find . -type f -name '*.pp' -exec puppet-lint {} \;

editorconfig:
	@git ls-files -z | grep -av patch | xargs -0 -r -n 100 $(shell npm bin)/eclint check

lint: splint puppet-lint editorconfig

cucumber:
	@bundle exec cucumber

clean:
	-rm -rf bin
