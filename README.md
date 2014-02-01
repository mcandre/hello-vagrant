# hello-vagrant - Hello World for Vagrant

# REQUIREMENTS

* [Vagrant](http://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)

# EXAMPLE

    $ vagrant box add precise64 http://files.vagrantup.com/precise64.box
    $ vagrant init precise64
    $ vagrant up
    $ vagrant ssh

    vagrant@precise64:/vagrant$ make
    gcc -O2 -Wall -o hello hello.c
    ./hello
    Hello Vagrant!

    vagrant@precise64:/vagrant$ make lint
    splint *.c *.h
    Splint 3.1.2 --- 03 May 2009

    Cannot open file: *.h

    Finished checking --- no warnings

    vagrant@precise64:/vagrant$ exit

    $ vagrant halt
