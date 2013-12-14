require 'spec_helper'

describe Honeybadger::Read::User do
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

  describe "initializing a new user by mapping attributes" do
    before :all do
      @attributes = FactoryGirl.attributes_for :user
    end

    it "should map the attributes to new user instance" do
      Honeybadger::Read::User.expects(:new).with(
        @attributes[:name],
        @attributes[:email]
      ).once
      Honeybadger::Read::User.map(@attributes)
    end
  end
end