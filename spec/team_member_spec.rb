require 'spec_helper'

describe Honeybadger::Read::TeamMember do

  describe "initializing a new normal team member" do
    before :all do
      @team_member = FactoryGirl.build :normal_team_member
    end

    it "should have a identifier" do
      @team_member.id.should == 1 
    end

    it "should have a name" do
      @team_member.name.should == "John Smith"
    end

    it "should have an email address" do
      @team_member.email.should == "john.smith@example.com"
    end

    it "should have an admin flag" do
      @team_member.admin.should == false
    end

    it "should have the date the team member was created" do
      @team_member.created_at.should == Date.today
    end
  end

  describe "initializing a new admin team member" do
    before :all do
      @team_member = FactoryGirl.build :admin_team_member
    end

    it "should have a identifier" do
      @team_member.id.should == 1 
    end

    it "should have a name" do
      @team_member.name.should == "John Smith"
    end

    it "should have an email address" do
      @team_member.email.should == "john.smith@example.com"
    end

    it "should have an admin flag" do
      @team_member.admin.should == true 
    end

    it "should have the date the team member was created" do
      @team_member.created_at.should == Date.today
    end
  end

  describe "admin?" do
    it "should be an admin" do
      @team_member = FactoryGirl.build :admin_team_member
      @team_member.admin?.should be_true
    end

    it "should not be an admin" do
      @team_member = FactoryGirl.build :normal_team_member
      @team_member.admin?.should be_false
    end
  end

  describe "all" do
    it "is pending"
  end

  describe "find" do
    it "is pending"
  end

  describe "initializing a list of team members by mapping attributes" do
    before :all do
      @attribute_collection = [
        FactoryGirl.attributes_for(:normal_team_member),
        FactoryGirl.attributes_for(:admin_team_member)
      ]
    end

    it "should map the attributes to a list of team member instances" do
      Honeybadger::Read::TeamMember.expects(:map).with(@attribute_collection.first).once
      Honeybadger::Read::TeamMember.expects(:map).with(@attribute_collection.last).once
      Honeybadger::Read::TeamMember.map_collection(@attribute_collection)
    end
  end

  describe "initializing a new team member by mapping attributes" do
    before :all do
      @attributes = FactoryGirl.attributes_for(:normal_team_member)
      @team_member = Honeybadger::Read::TeamMember.map(@attributes)
    end

    it "should map the attributes to new team member instance" do
      Honeybadger::Read::TeamMember.expects(:new).with(
        @attributes[:id],
        @attributes[:name],
        @attributes[:email],
        @attributes[:admin],
        @attributes[:created_at]
      ).once
      Honeybadger::Read::TeamMember.map(@attributes)
    end
  end
end