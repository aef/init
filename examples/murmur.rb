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

class Murmur < Init
  PATH = '/opt/murmur'
  DAEMON = File.join(PATH, 'murmur.x86')
  PIDFILE = '/var/run/murmur/murmur.pid'
  USER = 'mumble'

  # Defines the seconds to wait between stop and start in the predefined restart
  # command
  stop_start_delay 1

  # If not set this defaults to :restart
  default_command :start

  # An implementation of the start method for the mumble daemon
  def start
    system("start-stop-daemon --start --chdir #{PATH} --chuid #{USER} --exec #{DAEMON}")
  end

  # An implementation of the stop method for the mumble daemon
  def stop
    system("start-stop-daemon --stop --pidfile #{PIDFILE}")
  end
end

# The parser is only executed if the script is executed as a program, never
# when the script is required in a ruby program
if __FILE__ == $PROGRAM_NAME
  Murmur.parse
end
