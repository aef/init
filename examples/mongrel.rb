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
