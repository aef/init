#!/usr/bin/env ruby
# encoding: UTF-8
=begin
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
=end

### BEGIN INIT INFO
# Provides:          murmur
# Required-Start:    $local_fs $remote_fs $syslog $named $network $time
# Required-Stop:     $local_fs $remote_fs $syslog $named $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
### END INIT INFO

require 'init'

# An example init script for the server daemon of voice chat application Mumble
class Murmur < Aef::Init
  set(:path)    { Pathname('/opt/murmur') }
  set(:daemon)  { path + 'murmur.x86' }
  set(:pidfile) { Pathname('/var/run/murmur/murmur.pid') }
  set(:user)    { 'mumble' }

  # Defines the seconds to wait between stop and start in the predefined restart
  # command
  stop_start_delay 1

  # If not set this defaults to :restart
  default_command :start

  # An implementation of the start method for the mumble daemon
  def start
    system("start-stop-daemon --start --chdir #{path} --chuid #{user} --exec #{daemon}")
  end

  # An implementation of the stop method for the mumble daemon
  def stop
    system("start-stop-daemon --stop --pidfile #{pidfile}")
  end
end

# The parser is only executed if the script is executed as a program, never
# when the script is required in a ruby program
Murmur.parse if __FILE__ == $PROGRAM_NAME
