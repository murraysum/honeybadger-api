require 'spec_helper'

describe "Honeybadger::Api::VERSION" do
  it "should be version 1.0.0" do
    expect(Honeybadger::Api::VERSION).to eql("1.0.0")
  end
end