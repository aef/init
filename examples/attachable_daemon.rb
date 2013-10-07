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

require 'init'

# A base class for interactive processes run as daemons via tmux.
class AttachableDaemon < Aef::Init

  # Start a new tmux session as a different user and run a command within.
  def start
    `#{sudo} #{tmux} new-session -s "#{session_name}" "#{command}"`
  end

  # Kill the tmux session.
  def stop
    `#{sudo} #{tmux} kill-server`
  end

  # Attach to the tmux session.
  def console
    `#{sudo} #{tmux} attach`
  end

  # Start and attach to the tmux session.
  def cstart
    start
    console
  end

  # Restart and attach to the tmux session.
  def crestart
    restart
    console
  end

end
