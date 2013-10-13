require 'spec_helper'

describe Honeybadger::Read::Owner do
  describe "initializing a new owner" do
    before :all do
      @owner = FactoryGirl.build :owner
    end

    it "should have a name" do
      @owner.name.should == "Tom Smith"
    end

    it "should have an email address" do
      @owner.email.should == "tom.smith@example.com"
    end
  end

  describe "initializing a new owner by mapping attributes" do
    before :all do
      @attributes = FactoryGirl.attributes_for :owner
      @team_member = Honeybadger::Read::Owner.map @attributes
    end

    it "should map the attributes to new team member instance" do
      Honeybadger::Read::Owner.expects(:new).with(
        @attributes[:name],
        @attributes[:email]
      ).once
      Honeybadger::Read::Owner.map(@attributes)
    end
  end
end