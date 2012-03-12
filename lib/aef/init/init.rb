# encoding: UTF-8
=begin
Copyright Alexander E. Fischer <aef@raxys.net>, 2009-2012

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
=end

# Clean and simple *nix init scripts with Ruby
class Aef::Init
  VERSION = '1.2.1'.freeze

  # Call this to begin commandline parsing
  #
  # If an invalid command is specified on the commandline, a usage example is
  # displayed. If no command is specified, the default command is started
  def self.parse
    command = ARGV.shift || :default

    valid_commands = []

    self.ancestors.each do |klass|
      valid_commands += klass.public_instance_methods(false)
      break if klass == Aef::Init
    end

    valid_commands.uniq!

    @@default_command ||= 'restart'
    @@stop_start_delay ||= 0

    # This is neccessary because since ruby 1.9, the instance_methods method
    # returns an array of symbols instead of an array of strings which it did
    # in 1.8
    ruby_version_components = RUBY_VERSION.split('.').map(&:to_i)
    command = command.to_sym if ruby_version_components[0] >= 1 and ruby_version_components[1] >= 9

    if command == :default
      new.send(@@default_command)
    elsif valid_commands.include?(command)
      new.send(command)
    else
      puts "Usage: #$PROGRAM_NAME {#{valid_commands.sort.join('|')}}"; exit false
    end
  end

  # Set a delay in seconds between the call of the stop and the start method in
  # the predefined restart method
  def self.stop_start_delay(seconds)
    @@stop_start_delay = seconds
  end

  # Set a default command to be called if no command is specified on the
  # commandline.
  def self.default_command(command)
    @@default_command = command
  end

  # The start method needs to be implemented in a subclass
  def start
    warn 'start method needs to be implemented'; exit false
  end

  # The stop method needs to be implemented in a subclass
  def stop
    warn 'stop method needs to be implemented'; exit false
  end

  # By default restart simply calls stop and then start
  def restart
    stop
    sleep @@stop_start_delay
    start
  end
end
