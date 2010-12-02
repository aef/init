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
