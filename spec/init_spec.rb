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

require 'fileutils'
require 'tmpdir'

require 'rubygems'
require 'facets/timer'

module InitSpecHelper
  RUBY_PATH = 'ruby'

  def init_executable
    "#{RUBY_PATH} spec/bin/simple_init.rb"
  end
end

describe Aef::Init do
  before(:each) do
    # Before ruby 1.8.7, the tmpdir standard library had no method to create
    # a temporary directory (mktmpdir).
    if Gem::Version.new(RUBY_VERSION) < Gem::Version.new('1.8.7')
      @folder_path = File.join(Dir.tmpdir, 'init_spec')
      Dir.mkdir(@folder_path)
    else
      @folder_path = Dir.mktmpdir('init_spec')
    end
  end

  after(:each) do
    FileUtils.rm_rf(@folder_path)
  end

  include InitSpecHelper
  
  it "should correctly execute the start command" do
    start_output = File.join(@folder_path, 'start_output')

    lambda {
      `#{init_executable} start #{start_output}`.should be_true
    }.should change{File.exist?(start_output)}.from(false).to(true)

    File.read(start_output).should eql("#{start_output} --start --example -y\n")

  end

  it "should correctly execute the stop command" do
    stop_output = File.join(@folder_path, 'stop_output')

    lambda {
      `#{init_executable} stop #{stop_output}`.should be_true
    }.should change{File.exist?(stop_output)}.from(false).to(true)

    File.read(stop_output).should eql("#{stop_output} --stop --example -y\n")
  end

  it "should correctly execute the restart command" do
    restart_output = File.join(@folder_path, 'restart_output')

    lambda {
      `#{init_executable} restart #{restart_output}`.should be_true
    }.should change{File.exist?(restart_output)}.from(false).to(true)

    File.read(restart_output).should eql(
      "#{restart_output} --stop --example -y\n#{restart_output} --start --example -y\n")
  end

  it "should correctly execute the middle command" do
    middle_output = File.join(@folder_path, 'middle_output')

    lambda {
      `#{init_executable} middle #{middle_output}`.should be_true
    }.should change{File.exist?(middle_output)}.from(false).to(true)

    File.read(middle_output).should eql(
      "#{middle_output} --middle -e --abc\n")
  end

  it "should wait 3 seconds between stop and start through the restart command" do
    restart_output = File.join(@folder_path, 'restart_output')

    timer = Timer.new
    timer.start

    `#{init_executable} restart #{restart_output}`.should be_true

    timer.stop
    (timer.total_time.should > 1.5).should be_true
  end

  it "should display a usage example if a wrong command is specified" do
    usage_information = "Usage: spec/bin/simple_init.rb {middle|restart|start|stop}\n"

    `#{init_executable} invalid`.should eql(usage_information)
  end

  it "should only offer methods which are defined in Init or it's child classes" do
    usage_information = "Usage: spec/bin/simple_init.rb {middle|restart|start|stop}\n"

    `#{init_executable} methods`.should eql(usage_information)
    `#{init_executable} frozen?`.should eql(usage_information)
    `#{init_executable} to_a`.should eql(usage_information)
  end

  it "should only offer methods which are defined as public in Init or it's child classes" do
    usage_information = "Usage: spec/bin/simple_init.rb {middle|restart|start|stop}\n"
    
    `#{init_executable} middle_protected`.should eql(usage_information)
    `#{init_executable} middle_private`.should eql(usage_information)
    `#{init_executable} end_protected`.should eql(usage_information)
    `#{init_executable} end_private`.should eql(usage_information)
  end
end
