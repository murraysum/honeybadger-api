require 'spec_helper'

describe "Honeybadger::Api::VERSION" do
  it "should be version 2.0.0" do
    expect(Honeybadger::Api::VERSION).to eql("2.0.0")
  end
end