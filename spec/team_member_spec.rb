require 'spec_helper'

describe Honeybadger::Read::TeamMember do

  describe "initializing a new normal team member" do
    before :all do
      @team_member = FactoryGirl.build :normal_team_member
    end

    it "should have an identifier" do
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

    it "should have an identifier" do
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
end