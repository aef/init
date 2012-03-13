#!/usr/bin/env ruby
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

require 'rbconfig'

require 'aef/init'

# A library in between the base and the final class
class MiddleInit < Aef::Init
  INTERPRETER = Pathname(RbConfig::CONFIG['bindir']) + RbConfig::CONFIG['ruby_install_name']
  MOCK_EXECUTABLE = "#{INTERPRETER} spec/bin/mock_daemon.rb"

  def middle
    tempfile = ARGV.first
    system("#{MOCK_EXECUTABLE} #{tempfile} --middle -e --abc")
  end

  protected

  def middle_protected
    warn 'This should not be executable as a command'
    exit false
  end

  private

  def middle_private
    warn 'This should not be executable as a command'
    exit false
  end
end

# The final implementation
class SimpleInit < MiddleInit
  # Defines the seconds to wait between stop and start in the predefined restart
  # command
  stop_start_delay 1.5

  # If not set this defaults to :restart
  default_command :stop

  # An implementation of the start method for the mumble daemon
  def start
    tempfile = ARGV.first
    system("#{MOCK_EXECUTABLE} #{tempfile} --start --example -y")
  end

  # An implementation of the stop method for the mumble daemon
  def stop
    tempfile = ARGV.first
    system("#{MOCK_EXECUTABLE} #{tempfile} --stop --example -y")
  end

  protected

  def end_protected
    warn 'This should not be executable as a command'
    exit false
  end

  private

  def end_private
    warn 'This should not be executable as a command'
    exit false
  end
end

# The parser is only executed if the script is executed as a program, never
# when the script is required in a ruby program
if __FILE__ == $PROGRAM_NAME
  SimpleInit.parse
end
