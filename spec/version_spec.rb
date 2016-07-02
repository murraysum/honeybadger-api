require 'spec_helper'

describe "Honeybadger::Api::VERSION" do
  it "should be version 1.2.1" do
    expect(Honeybadger::Api::VERSION).to eql("1.2.1")
  end
end