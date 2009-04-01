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

# This is a simple mock daemon which will write all commandline arguments it
# recevies to a file specified as first commandline option

if ARGV.empty?
  puts "Usage: #$PROGRAM_NAME output_file [arguments]"
else
  puts arguments = ARGV.join(' ')
  puts output_file = ARGV.first

  File.open(output_file, 'a') do |f|
    f.puts(arguments)
  end
end
