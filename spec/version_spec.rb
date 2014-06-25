require 'spec_helper'

describe "Honeybadger::Api::VERSION" do
  it "should be version 1.0.0" do
    Honeybadger::Api::VERSION.should == "1.0.0"
  end
end