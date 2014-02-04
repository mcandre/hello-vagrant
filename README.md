# hello-vagrant - Hello World for Vagrant

![Vagrant logo](http://www.yellosoft.us/public/images/vagrant.png)

# ABOUT

hello-vagrant presents a small demo project for newbies to Vagrant, a tool for managing per-application environments, shrink-wrapping them for deployment, and for each project contributor. In the demo, we setup a virtual machine (vm) for working on Hello Vagrant, a pretend software application.

# REQUIREMENTS

* [Vagrant](http://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)
* Some familiarity with command line terminals

# SCENARIO: WAKE UP CALL

![YelloSoft: "We make software. Ug."](https://raw2.github.com/mcandre/hello-vagrant/master/yellosoft.png)

Management at YelloSoft Company & Company has embarked on a trillion-dollar, bleeding edge project to develop the world's foremost Hello World app. Management isn't really sure what the app should do, besides print Hello..., but they know how they want the app to be made.

> Project Requirements:
>
> The application shall say Hello (something).
> All development work shall be version controlled.
> All developer tools shall be documented. Developers may spend some time upfront provisioning tools, but new developers must be able to quickly acquiaint themselves with the project.
> Quality control tests shall be approved by management.
> When a new version passes the tests, the application shall be deployed on our Linux servers.
> The application shall be written in C.

The developers receive the project requirements and settle on some solutions to meet them.

> Developer Manifesto:
>
> The application shall be written in an ANSI-compatible subset of C that compiles in gcc and passes a linter.
> Indentation for application source code is two spaces.
> Developers will be handed a laptop with install permissions for Vagrant and VirtualBox, and Vim, and a paper copy of [Learning the vi and Vim Editors](http://www.amazon.com/dp/059652983X/). Developer Bob will use Emacs and YelloSoft Co. & Co. will not fight him on this.

Management needs Bob, and accepts the developer's technical details on the condition that the trillion-dollar app be deployed by close of business Monday (it's Thursday afternoon). Then management finally informs the testers that they'll soon be cracking on Hello app, because testing must be done by close of business Monday (but it's Thursday afternoon)!

> Testing Procedures:
>
> The Hello application should feature a command line interface to support our automated Ruby testing system.
> The build system should be scripted, we have no idea how to write C code or use gcc.
> Developers should clearly document how to build and run Hello app.

Management blinks at each other in confusion--command line what? But eventually understands that Hello $Trillion is going to have trouble being sufficiently bug-free for Joe $Dollar consumer, unless it's designed from the start to be highly testable. You can't have Hello World exploding the Internets or virussing your bytes, or whatever happens when you don't put enough developer butts in app-making seats.

As the first light of dawn strikes YelloSoft Co. & Co. headquarters, the Ops team hears through the grapevine that a new, mission-critical Hello app will be shoved onto the production servers some time on Monday. The developers know we only have Ubuntu, right? And our servers aren't backwards compatible with Ruby 1.9? The Ops team rush to informally collect technical details from coworkers, writing down truths, hearsay, vagaries, and outright lies, and collecting them into a massive Ops specification broadcast with all the details Ops need to know in order to deploy enterprise-level applications onto live production systems.

> Vim approved by management.

# PROBLEM

![Now -> Monday. Not enough time](https://raw2.github.com/mcandre/hello-vagrant/master/project-plan.png)

Software is incredibly complex. Large software projects are ridiculously complex, and whole faiths develop over the tiniest details--hard tabs or soft tabs; Emacs or Vim; Mac, Windows, or Linux--and managing all the details is patently wasteful. Decisions are required in order for the product to be meaningfully considered "software", but the particular choices often seem arbitrary.

Hello app could be a record breaker, at least in terms of expenses. At worst, Hello app might be a massive business and technical failure, as all the parts, human and computer, fail to work together. How can we organize this chaos? How can we keep everyone on the same page?

# SOLUTION: VAGRANT!

![old vagrant](https://raw2.github.com/mcandre/hello-vagrant/master/old-vagrant.png) Er. ![new vagrant](https://raw2.github.com/mcandre/hello-vagrant/master/new-vagrant.png)

Vagrant is free, open source software for managing computer environment configuration. The tools, packages, databases, user accounts, files and folders are used by Developers, Testers, and Operators can be documented in a tiny Vagrant virtual machine (vm), and everyone can refer to the Vagrant vm when in doubt. Project not compiling? Run it in Vagrant. Test suite not installing? Run it in Vagrant. Deployment overly complicated? Run it in Vagrant. Everyone syncs on the same technical configuration, without having to spend hours fussing with the configuration.

You might have used vm's before, they're handy for running Linux inside of Windows, or Windows inside of Windows, or Linux inside of Windows inside of Mac. Vms isolate software into individual computational units, so that everything plays nicely on an economical set of computer hardware.

Vagrant takes the vm idea one step further, encouring vm use for each application. This might sound like overkill for small programs like Hello app, but as apps and their resource needs grow, isolating them in vms is a good way to keep them maintainable and interoperable--if app A needs version X but app B needs version Y, that's okay. It's like they live in entirely different worlds.

# DEMO BY LUNCH

Step one is downloading a base vm. At YelloSoft Co. & Co., our applications will start with a layer of Ubuntu and build on top.

Instruct Vagrant to download a base Ubuntu vm, Precise Pangolin, 64-bit. The download may take a little while, depending on the network connection.

    $ vagrant box add precise64 http://files.vagrantup.com/precise64.box

Now our computer has a base Ubuntu box that we can reuse in a lot of projects.

    $ ls ~/.vagrant.d/boxes/
    precise64

Instruct Vagrant to use this base for our Hello app project.

    $ cd hello-vagrant/
    $ vagrant init precise64

Boot the vm in the background.

    $ vagrant up

Apply the latest configuration rules.

    $ vagrant provision

Connect to the vm in a terminal session.

    $ vagrant ssh

Developers can write, build, and run the Hello Vagrant application.

    vagrant@precise64:/vagrant$ vi hello.c
    :q

    vagrant@precise64:/vagrant$ make
    gcc -O2 -Wall -o hello hello.c
    
    vagrant@precise64:/vagrant$ ./hello
    Hello Vagrant!

Developer Bob prefers another text editor, Emacs. He can edit the source code outside the vm, building and running the app inside the vm, using Vagrant's automatic mirroring of project files into the vm as a shared folder, `/vagrant`. He can use any text editor of his choice this way! Which is good, because the Management likes to poke around the code in Notepad for off the cuff "Assurance" inspections against evil Developers.

    $ emacs hello.c
    C-x C-c

    $ vagrant ssh

    vagrant@precise64:/vagrant$ make
        gcc -O2 -Wall -o hello hello.c

    vagrant@precise64:/vagrant$ ./hello
        Hello Vagrant!

Every now and then, the Developers have a meeting for code review, using a linter to assist in identifying sections of code to improve. So far, no warnings!

    vagrant@precise64:/vagrant$ make lint
    splint *.c *.h
    Splint 3.1.2 --- 03 May 2009

    Cannot open file: *.h

    Finished checking --- no warnings

Bob likes to have lots of linter programs installed on his normal work computer, so he can code review outside the vm.

    $ splint *.c *.h

At 10 o'clock, several new Developers finish inprocessing at YelloSoft Co. & Co., and management reassigns the current team to getting the new members up to speed on developing Hello app ("and have them do a code review"). The Newbies are issued a hodgepodge of laptops, some Mac, some Windows or Linux. And installing splint on all of them would be a pain. Instead, Bob shows them [Vagrant](http://www.vagrantup.com/) + [VirtualBox](https://www.virtualbox.org/), and they boot up shiny new Hello app vms.

    $ vagrant up
    $ vagrant ssh
    vagrant@precise64:/vagrant$ make lint
    splint *.c *.h
    Splint 3.1.2 --- 03 May 2009
    
    Cannot open file: *.h
    
    Finished checking --- no warnings

Excellent work for your first day, Newbies! And they don't even know which tools they're using.

Meanwhile, Testing is working on plain English descriptions of features to test.

    $ cat features/print_hello_vagrant.feature
    Feature: Print hello vagrant
    
      Scenario: Running hello vagrant
        Given the program has finished
        Then the output is hello vagrant

Testers get the go-head from Management, and translate each requirement into little Ruby code.

    $ cat features/step_definitions/steps.rb
    Given(/^the program has finished$/) do
      `make clean && make`
      @cucumber = `./hello`
    end

    Then(/^the output is hello vagrant$/) do
      @cucumber.chop.should == 'Hello Vagrant!'
    end

This handy [Cucumber](https://github.com/cucumber) test ensures the trillion-dollar Hello application meets quality control requirements: the app must say `Hello Vagrant!`

Senior Quality Assurance Officer Jill still has Ruby 1.9 and Windows XP on her work computer, for supporting a legacy Goodbye World app she still maintains. She could use RVM to install Ruby 2.0 for Hello app, but neither RVM nor Cucumber work well in Windows. What's worse, she prefers to manage her Ruby dependencies with [Bundler](http://bundler.io/), rather than leaving it to Ops to handle the details. Fortunately, she's able to boot up and run Cucumber anyway, with a collection of tiny configuration scripts: Vagrant to Puppet to Bundler, that keep everything running smoothly.

    C:\> vagrant up
    C:\> vagrant ssh
    vagrant@precise64:/vagrant$ cucumber
    Feature: Print hello vagrant
    
      Scenario: Running hello vagrant    # features/print_hello_vagrant.feature:3
        Given the program has finished   # features/step_definitions/steps.rb:1
        Then the output is hello vagrant # features/step_definitions/steps.rb:6
    
    1 scenario (1 passed)
    2 steps (2 passed)
    0m0.227s

An hour later, the test no longer passes--one of the Newbies broke the code. Jill shows the Newbie the Cucumber test output. "Which versions of such and such are you using," asks the Developer. "Latest Cucumber, RubyGems, make, and gcc, as documented in the default.pp file," replies Jill. "Oops, I was running the app on my BSD laptop, didn't see the error." The Newbie boots the vm, runs the app *there*, sees the error, tweaks the code with Bob's [custom](https://github.com/mcandre/dotfiles/blob/master/.emacs) Emacs outside the vm, commits the source code, watches the app pass `cucumber` in the vm, and confirms with Jill that the app is stable again. In the evening, the app seems to work, Management's happy, and everyone leaves for the weekend.

At the stroke of midnight, Monday, an priority advisory appears:

> OpenSSH vulnerability found. Patched released, update ASAP.

The Ops members on watch `apt-get update && apt-get upgrade`, legacy apps continue normal function.

As the morning courses on, a manager walks by Newbie Developer, and sees the colorful text editor session, mistaking it for the app--"I want to demo that at Lunch." Manager walks away after dropping that bomb, concerned with how or whether to get sandwiches for the trillion-dollar Hello Lunch Demo.

Newbie Developer talks to Bob. Bob says, "The *deployment* wasn't even scheduled until the afternoon! But we gotta demo." Newbie, Bob, Jill, and Ops Team scramble to make something, semi-functional, that shouts to all the world, `Hello Hello Hello!!!` for Management to see.

Somehow, the OpenSSH update breaks Hello app, and then a series of carefully planned and highly technical activities occur in sequence ("magic happens").

11:49:00 Ops team modifies `defaults.pp` to update to the new version, passes along the new envirnment to Testing.

11:49:23 Testing runs `vagrant provision`, `vagrant ssh`, `cucumber`, sees the error, passes the error and the modified `defaults.pp` to Developers.

11:59:23 Developers `vagrant provision`, `vagrant ssh`, code until `cucumber` passes, pushes branch `lunchdemo` to Testing.

11:59:30 Testing reruns `cucumber` on the new application build, watches it pass, pushes to Ops.

11:59:59 Ops sees the new tested build, pulls the new app to deployment, runs `vagrant up`.

12:00:00 Sandwiches.

![sandwich resembling The Muppets' Dr. Teeth](https://raw2.github.com/mcandre/hello-vagrant/master/sandwich.jpg)

    vagrant@precise64:/vagrant$ exit
