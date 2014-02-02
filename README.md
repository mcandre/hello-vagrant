# hello-vagrant - Hello World for Vagrant

# ABOUT

hello-vagrant presents a small demo project for newbies to Vagrant, a tool for shrink-wrapping and version controlling reusable, per-application environments. In the demo, users setup a virtual machine (vm) for working on Hello Vagrant, a pretend software application.

# REQUIREMENTS

* [Vagrant](http://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)
* Some familiarity with command line terminals

# DEMO

Instruct Vagrant to download a base Ubuntu vm, which we will extend to become our Hello Vagrant custom vm. The download may take a little while, depending on the network connection.

    $ vagrant box add precise64 http://files.vagrantup.com/precise64.box
    $ vagrant init precise64

Boot the vm in the background.

    $ vagrant up

By default, Vagrant enforces the provisioning configuration in `Vagrantfile` and `manifests/default.pp`. If we tweak the configuration, we can apply new settings while the vm is still running.

    $ vagrant provision

Connect to the vm in a terminal session.

    $ vagrant ssh

Build and run the Hello Vagrant application.

    vagrant@precise64:/vagrant$ make
    gcc -O2 -Wall -o hello hello.c
    vagrant@precise64:/vagrant$ ./hello
    Hello Vagrant!

Optionally, run a linter over the source code. For developers, this would help keep the code tidy.

    vagrant@precise64:/vagrant$ make lint
    splint *.c *.h
    Splint 3.1.2 --- 03 May 2009

    Cannot open file: *.h

    Finished checking --- no warnings

Optionally, run a test suite over the built application. For tests, this keeps the application functional.

    vagrant@precise64:/vagrant$ cucumber
    Feature: Print hello world
    
      Scenario: Running hello world    # features/print_hello_world.feature:3
        Given the program has finished # features/step_definitions/steps.rb:1
        Then the output is hello world # features/step_definitions/steps.rb:6
    
    1 scenario (1 passed)
    2 steps (2 passed)
    0m0.063s

Exit the vm terminal session.

    vagrant@precise64:/vagrant$ exit

Shutdown the vm.

    $ vagrant halt

Optionally, delete the Hello Vagrant vm and/or the base Ubuntu vm to save space.

    $ vagrant destroy

And/or:

    $ vagrant box remove preceise64

# DEBRIEF

    vagrant@precise64:/vagrant$ tree
    .
    |-- features
    |   |-- print_hello_world.feature
    |   `-- step_definitions
    |       `-- steps.rb
    |-- hello
    |-- hello.c
    |-- Makefile
    |-- manifests
    |   `-- default.pp
    |-- README.md
    `-- Vagrantfile
    
    3 directories, 8 files

`hello` - We begin with the application you want to develop and deploy (Hello Vagrant!) Sysadmins will want to know which operating system(s), software package(s), and special environment configurations are required in order to install and run the app. Testers will want a clean, standalone way to quickly setup and test the application against their battery of hundreds of stringent quality control tests (It should say "Hello Vagrant!").

`hello.c` - Source code for Hello Vagrant app. Someone decided the app would be written in C, and someone must decide on a compiler and an operating system. For this project, we chose `gcc` and Ubuntu Linux, and require that all developers, testers, and sysadmins familiarize themselves with Linux (gcc- or Ubuntu-specific knowledge is a bonus skill).

We could have decided on Visual Studio tools instead of `gcc`, and Windows instead of Linux. The wonder of Vagrant is that it works for many environments--you can use whatever you need inside the vm, and use whatever you like outside the vm, for your host computer. You can even use your favorite text editor on the project files, because Vagrant mirrors the project into the vm as a shared folder, `/vagrant`.

`Makefile` - Build script for Hello Vagrant. This makes it easier for developers to compile the app, something they will be doing very often as they tweak the code. This also reduces the need for other team members to understand `gcc` and C--they just run `make` and the app builds. An optional build step for developers, `make lint`, is offered to keep the source code tidy.

`manifests/default.pp` - Puppet script describing the specific environment required to run Hello Vagrant. In detail, this means `gcc`, `make`, and `splint`, all available in just two packages, `build-essential` and `splint`. We also create a symlink to `.bash_profile` to start the vm user shell in the Hello Vagrant project directory.

`README.md` - Every project should have a README! Try to strike a balance between readability for general audiences and technical depth where necessary. How's the demo going so far?

`Vagrantfile` - High level configuration for a vm made just for the Hello Vagrant app. None of the technical details above are particularly relevant to anyone; we just run `vagrant up` and do our jobs. But if we didn't use Vagrant, ever team member would have to individually learn the nitty gritty details of [yak shaving](http://www.urbandictionary.com/define.php?term=yak%20shaving), wasting many man-months.
