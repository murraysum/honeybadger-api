require 'spec_helper'

describe Honeybadger::Api::User do
  describe "initializing a new user" do
    before :all do
      @user = FactoryGirl.build :user
    end

    it "should have a name" do
      @user.name.should == "Tom Smith"
    end

    it "should have an email address" do
      @user.email.should == "tom.smith@example.com"
    end
  end
end