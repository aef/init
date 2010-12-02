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

require './spec/spec_helper'

require 'facets/timer'

describe Aef::Init do
  before(:each) do
    @temp_dir = create_temp_dir
  end

  after(:each) do
    @temp_dir.rmtree
  end

  it "should correctly execute the start command" do
    start_output = @temp_dir + 'start_output'

    lambda {
      `#{executable} start #{start_output}`.should be_true
    }.should change{start_output.exist?}.from(false).to(true)

    start_output.read.should == "#{start_output} --start --example -y\n"

  end

  it "should correctly execute the stop command" do
    stop_output = @temp_dir + 'stop_output'

    lambda {
      `#{executable} stop #{stop_output}`.should be_true
    }.should change{stop_output.exist?}.from(false).to(true)

    stop_output.read.should == "#{stop_output} --stop --example -y\n"
  end

  it "should correctly execute the restart command" do
    restart_output = @temp_dir + 'restart_output'

    lambda {
      `#{executable} restart #{restart_output}`.should be_true
    }.should change{restart_output.exist?}.from(false).to(true)

    restart_output.read.should ==
      "#{restart_output} --stop --example -y\n#{restart_output} --start --example -y\n"
  end

  it "should correctly execute the middle command" do
    middle_output = @temp_dir + 'middle_output'

    lambda {
      `#{executable} middle #{middle_output}`.should be_true
    }.should change{middle_output.exist?}.from(false).to(true)

    middle_output.read.should == "#{middle_output} --middle -e --abc\n"
  end

  it "should wait 3 seconds between stop and start through the restart command" do
    restart_output = @temp_dir + 'restart_output'

    timer = Timer.new
    timer.start

    `#{executable} restart #{restart_output}`.should be_true

    timer.stop
    (timer.total_time.should > 1.5).should be_true
  end

  it "should display a usage example if a wrong command is specified" do
    usage_information = "Usage: spec/bin/simple_init.rb {middle|restart|start|stop}\n"

    `#{executable} invalid`.should == usage_information
  end

  it "should only offer methods which are defined in Init or it's child classes" do
    usage_information = "Usage: spec/bin/simple_init.rb {middle|restart|start|stop}\n"

    `#{executable} methods`.should == usage_information
    `#{executable} frozen?`.should == usage_information
    `#{executable} to_a`.should == usage_information
  end

  it "should only offer methods which are defined as public in Init or it's child classes" do
    usage_information = "Usage: spec/bin/simple_init.rb {middle|restart|start|stop}\n"
    
    `#{executable} middle_protected`.should == usage_information
    `#{executable} middle_private`.should == usage_information
    `#{executable} end_protected`.should == usage_information
    `#{executable} end_private`.should == usage_information
  end
end
