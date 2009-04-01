#!/usr/bin/env ruby
#
# Copyright 2009 Alexander E. Fischer <aef@raxys.net>
#
# This file is part of Init.
#
# Init is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'lib/init'

# A library in between the base and the final class
class MiddleInit < Init
  RUBY_PATH = 'ruby'
  MOCK_EXECUTABLE = "#{RUBY_PATH} spec/bin/mock_daemon.rb"

  def middle
    tempfile = ARGV.first
    system("#{MOCK_EXECUTABLE} #{tempfile} --middle -e --abc")
  end

  protected

  def middle_protected
    warn 'This should not be executable as a command'; exit false
  end

  private

  def middle_private
    warn 'This should not be executable as a command'; exit false
  end
end

# The final implementation
class SimpleInit < MiddleInit
  RUBY_PATH = 'ruby'
  MOCK_EXECUTABLE = "#{RUBY_PATH} spec/bin/mock_daemon.rb"

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
    warn 'This should not be executable as a command'; exit false
  end

  private

  def end_private
    warn 'This should not be executable as a command'; exit false
  end
end

# The parser is only executed if the script is executed as a program, never
# when the script is required in a ruby program
if __FILE__ == $PROGRAM_NAME
  SimpleInit.parse
end
