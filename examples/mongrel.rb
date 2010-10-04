#!/usr/bin/env ruby
#
# Copyright Alexander E. Fischer <aef@raxys.net>, 2009-2010
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

require 'aef/init'

class Mongrel < Aef::Init
  BASE_DIR = Pathname('/srv/rails')
  APPS = {
    'my_project' => 8000,
    'demo_app' => 8001
  }

  stop_start_delay 3

  # An implementation of the start method
  def start
    APPS.each do |app_name, port|
      puts "Starting #{app_name} on #{port}..."
     `mongrel_rails start -d -p #{port} -e production -c #{BASE_DIR + app_name} -P log/mongrel.pid`
    end
  end

  # An implementation of the stop method
  def stop
    APPS.each do |app_name, port|
      puts "Stopping #{app_name}..."
      `mongrel_rails stop -c #{BASE_DIR + app_name} -P log/mongrel.pid`
    end
  end
end

# The parser is only executed if the script is executed as a program, never
# when the script is required in a ruby program
if __FILE__ == $PROGRAM_NAME
  Mongrel.parse
end
