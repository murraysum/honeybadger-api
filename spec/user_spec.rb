require 'spec_helper'

describe Honeybadger::Api::User do
  describe "initializing a new user" do
    before :all do
      @user = FactoryGirl.build :user
    end

    it "should have a name" do
      expect(@user.name).to eql("Tom Smith")
    end

    it "should have an email address" do
      expect(@user.email).to eql("tom.smith@example.com")
    end
  end
end