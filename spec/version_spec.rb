require 'spec_helper'

describe "Honeybadger::Api::VERSION" do
  it "should be version 0.0.1" do
    Honeybadger::Api::VERSION.should == "0.0.1"
  end
end