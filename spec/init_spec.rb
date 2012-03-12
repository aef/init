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
