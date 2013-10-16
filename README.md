Init
====

[![Gem Version](https://badge.fury.io/rb/init.png)](https://badge.fury.io/rb/init)
[![Build Status](https://secure.travis-ci.org/aef/init.png)](https://secure.travis-ci.org/aef/init)
[![Dependency Status](https://gemnasium.com/aef/init.png)](https://gemnasium.com/aef/init)
[![Code Climate](https://codeclimate.com/github/aef/init.png)](https://codeclimate.com/github/aef/init)
[![Coverage Status](https://coveralls.io/repos/aef/init/badge.png?branch=master)](https://coveralls.io/r/aef/init)

* [Documentation][docs]
* [Project][project]

   [docs]:    http://rdoc.info/github/aef/init/
   [project]: https://github.com/aef/init/

Description
-----------

Init is a lightweight framework for writing readable, reusable *nix init
scripts in Ruby.

Features / Problems
-------------------

This project tries to conform to:

* [Semantic Versioning (2.0.0)][semver]
* [Ruby Packaging Standard (0.5-draft)][rps]
* [Ruby Style Guide][style]
* [Gem Packaging: Best Practices][gem]

   [semver]: http://semver.org/
   [rps]:    http://chneukirchen.github.com/rps/
   [style]:  https://github.com/bbatsov/ruby-style-guide
   [gem]:    http://weblog.rubyonrails.org/2009/9/1/gem-packaging-best-practices

Additional facts:

* Written purely in Ruby.
* Documented with YARD.
* Automatically testable through RSpec.
* Intended to be used with Ruby 1.9.3 or higher.
* Cryptographically signed gem and git tags.

Synopsis
--------

This documentation defines the public interface of the software. Don't rely
on elements marked as private. Those should be hidden in the documentation
by default.

### Loading

In most cases you want to load the library by the following command:

~~~~~ ruby
require 'init'
~~~~~

In a bundler Gemfile you should use the following:

~~~~~ ruby
gem 'init'
~~~~~

### Writing init scripts

Simply subclass Aef::Init and define at least a start and a stop method. At the
end, call the parse method on that class.

~~~~~ ruby
  class DemoSubclass < Aef::Init
    def start
      system('echo start')
    end

    def stop
      system('echo stop')
    end
  end
  
  DemoSubclass.parse
~~~~~

To be able to call the commands from Ruby you should wrap the parse method call
in a block that only calls it if the script is executed on the commandline.

~~~~~ ruby
  if __FILE__ == $PROGRAM_NAME
    DemoSubclass.parse
  end
~~~~~

There is no need to implement the command restart in most cases, as there is one
defined by default, which simply calls the commands stop and start in a row.
A delay in seconds between the two commands can be defined:

~~~~~ ruby
  class DemoSubclass < Aef::Init
    …
    stop_start_delay 3
    …
  end
~~~~~

Notice that in earlier versions the default command was preset to :restart
which was not as useful in practice as expected. Many unwanted restarts were
triggered because of this, so I don't recommend using this feature any more.

Still, a default command can be specified which is called if no command is provided on the command-line:

~~~~~ ruby
  class DemoSubclass < Aef::Init
    …
    default_command :start
    …
  end
~~~~~

If you want to share commands between init scripts, you can simply insert an
intermediate class between Init and the final implementation. This way you can
build reusable libraries and keep your code DRY.

~~~~~ ruby
  class CommonCommands > Aef::Init
    def common
      system('echo common')
    end
  end

  class DemoSubclass > CommonCommands
    …
  end
~~~~~

As of 2.1.0 there is a way to specify lazily-interpreted variables which are
inherited by sub classes.

~~~~~ ruby
  class MiddleClass < Aef::Init
    # Setting some variables
    set(:executable) { 'daemon' }
    set(:arguments)  { '-abc' }

    # Access variables inside the defintion of a new one
    set(:command) { path + executable }

    # Utilize the variables in command definitions just like local variables
    def start
      `#{command} #{arguments}`
    end
  end

  class LeafClass < MiddleClass
    # Overrides the previous value 'daemon'
    set(:daemon) { 'special-daemon' }

    # Sets the needed but previously undefined path variable
    set(:path)   { Pathname.new('/opt/something') }
  end
~~~~~

See the examples/ folder and spec/bin/simple_init.rb for working example classes.

Requirements
------------

* Ruby 1.9.3 or higher

Installation
------------

On *nix systems you may need to prefix the command with sudo to get root
privileges.

### High security (recommended)

There is a high security installation option available through rubygems. It is
highly recommended over the normal installation, although it may be a bit less
comfortable. To use the installation method, you will need my [gem signing
public key][gemkey], which I use for cryptographic signatures on all my gems.

Add the key to your rubygems' trusted certificates by the following command:

    gem cert --add aef-gem.pem

Now you can install the gem while automatically verifying its signature by the
following command:

    gem install init -P HighSecurity

Please notice that you may need other keys for dependent libraries, so you may
have to install dependencies manually.

   [gemkey]: https://aef.name/crypto/aef-gem.pem

### Normal

    gem install init

### Automated testing

Go into the root directory of the installed gem and run the following command
to fetch all development dependencies:

    bundle

Afterwards start the test runner:

    rake spec

If something goes wrong you should be noticed through failing examples.

Development
-----------

### Bug reports and feature requests

Please use the [issue tracker][issues] on github.com to let me know about errors
or ideas for improvement of this software.

   [issues]: https://github.com/aef/init/issues/

### Source code

#### Distribution

This software is developed in the source code management system Git. There are
several synchronized mirror repositories available:

* GitHub (located in California, USA)
    
    URL: https://github.com/aef/init.git

* Gitorious (located in Norway)
    
    URL: https://git.gitorious.org/init/init.git

* BitBucket (located in Colorado, USA)
    
    URL: https://bitbucket.org/alefi/init.git

* Pikacode (located in France)

    URL: https://pikacode.com/aef/init.git

You can get the latest source code with the following command, while
exchanging the placeholder for one of the mirror URLs:

    git clone MIRROR_URL

#### Tags and cryptographic verification

The final commit before each released gem version will be marked by a tag
named like the version with a prefixed lower-case "v", as required by Semantic
Versioning. Every tag will be signed by my [OpenPGP public key][openpgp] which
enables you to verify your copy of the code cryptographically.

   [openpgp]: https://aef.name/crypto/aef-openpgp.asc

Add the key to your GnuPG keyring by the following command:

    gpg --import aef-openpgp.asc

This command will tell you if your code is of integrity and authentic:

    git tag -v [TAG NAME]

#### Building gems

To package your state of the source code into a gem package use the following
command:

    rake build

The gem will be generated according to the .gemspec file in the project root
directory and will be placed into the pkg/ directory.

### Contribution

Help on making this software better is always very appreciated. If you want
your changes to be included in the official release, please clone the project
on github.com, create a named branch to commit, push your changes into it and
send a pull request afterwards.

Please make sure to write tests for your changes so that no one else will break
them when changing other things. Also notice that an inclusion of your changes
cannot be guaranteed before reviewing them.

The following people were involved in development:

- Alexander E. Fischer

License
-------

Copyright Alexander E. Fischer <aef@raxys.net>, 2009-2013

This file is part of Init.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
