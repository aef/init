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
