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
require 'pathname'
require 'tmpdir'
require 'rubygems'
require 'rspec'
require 'aef/init'

module Aef::Init::SpecHelper
  INTERPRETER = Pathname(RbConfig::CONFIG['bindir']) + RbConfig::CONFIG['ruby_install_name']

  def create_temp_dir
    # Before ruby 1.8.7, the tmpdir standard library had no method to create
    # a temporary directory (mktmpdir).
    if Gem::Version.new("#{RUBY_VERSION}") < Gem::Version.new('1.8.7')
      temp_dir = Pathname(Dir.tmpdir) + 'init_spec'
      Dir.mkdir(temp_dir)
      temp_dir
    else
      Pathname(Dir.mktmpdir('init_spec'))
    end
  end

  def executable
    "#{INTERPRETER} -Ilib spec/bin/simple_init.rb"
  end
end

RSpec.configure do |config|
  config.include Aef::Init::SpecHelper
end
