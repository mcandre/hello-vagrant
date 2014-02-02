# hello-vagrant - Hello World for Vagrant

# ABOUT

hello-vagrant presents a small Vagrant project for Vagrant newbies. In this demonstration, users prepare and use a virtual development environment for `hello`, a C application printing `Hello Vagrant!`.

## Project Files in `hello-vagrant/`

`hello.c` - It all starts with the source code for the Hello Vagrant, a pretend C application you want to develop and deploy.

`Makefile` - Build script for compiling and running Hello Vagrant. By automating the build steps, we ensure that compilation is easy, fast, and reproducible. An optional build step, `make lint`, runs additional software analysis tools to improve the source code.

For Hello Vagrant, a Makefile may be overkill, but in larger applications, a good build system is worth its weight in bitcoins.

`bootstrap.sh` - Environment setup script for provisioning the required software development tools: `gcc`, `make`, `splint`. The faster and easier setting up the dev environment, the faster and easier it is for developers to join the project. If any databases or other complex setups are required, installation steps can be written here once, and reused many times.

For more advanced environment setup scripts, Vagrant also works with [Chef](http://www.getchef.com/chef/) and [Puppet](http://puppetlabs.com/).

`Vagrantfile` - High level configuration for a Ubuntu-based virtual machine (vm). Developers, testers, and system administrators can all sync on a single environment for the application, regardless of their host operating system.

VM settings like memory size and [port forwarding](https://docs.vagrantup.com/v2/networking/forwarded_ports.html) can also be added here.

`.gitignore` - A list of file patterns to exclude from version control. We exclude the `.vagrant/` directory that Vagrant uses for internal data, and the compiled unix executable `hello`.

Notice that the development environment for Hello Vagrant is not OS-agnostic, but very Unix-centric. By constraining ourselves to a single platform, we reduce time spent on OS and editor wars. We could have chosen a very Windows-centric environment, with Visual Studio tools instead of gcc--it's all gravy for the individual, who may run the Vagrant vm from Windows, Mac, or Linux.

As a bonus, Vagrant exposes the project files to the vm in a shared folder `/vagrant/`, so users can work with any text editor on the application code outside of Vagrant, and built/test/deploy in Vagrant. If one team member wants to use Visual Studio and another wants to use Vim, Vagrant is happy either way.

If OS-agnosticism is important in the product, Vagrant can help organize that too. Just write a `Vagrantfile` for each OS port. And either provide separate build scripts for each Vagrant environment, or write an uber build script and share it to both!

# REQUIREMENTS

* [Vagrant](http://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)

E.g., Mac users can `brew cask install vagrant virtualbox`.

# EXAMPLE

After Vagrant and VirtualBox are installed, use Vagrant to download a pristine, base copy of an Ubuntu Precise 12.04 x64 vm. This may take a little time, based on the size of the vm.

    $ vagrant box add precise64 http://files.vagrantup.com/precise64.box

Construct a vm just for this hello-vagrant project, using `precise64` as a base vm.

    $ vagrant init precise64

Boot the vm in the background.

    $ vagrant up

Connect to the vm in a terminal session. Vagrant sets up a shared folder `/vagrant/` that appears to the vm just like the `hello-vagrant/` project folder.

    $ vagrant ssh

    vagrant@precise64:/vagrant$ ls -A
    hello    Makefile   .vagrant
    bootstrap.sh   .gitignore  hello.c  README.md  Vagrantfile.bash_profile  .git

Build and run the Hello Vagrant application.

    vagrant@precise64:/vagrant$ make
    gcc -O2 -Wall -o hello hello.c
    ./hello
    Hello Vagrant!

Optionally, run a linter developer tool over the source code.

    vagrant@precise64:/vagrant$ make lint
    splint *.c *.h
    Splint 3.1.2 --- 03 May 2009

    Cannot open file: *.h

    Finished checking --- no warnings

Exit the vm terminal session.

    vagrant@precise64:/vagrant$ exit

Shutdown the vm.

    $ vagrant halt
