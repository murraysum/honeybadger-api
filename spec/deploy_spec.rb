require 'spec_helper'

describe Honeybadger::Read::Deploy do
  
  describe "initializing a new deploy" do
    before :all do
      @deploy = FactoryGirl.build :deploy
    end

    it "should have a identifier" do
      @deploy.id.should == 1 
    end

    it "should have a project identifier" do
      @deploy.project_id.should == 2 
    end

    it "should have a repository" do
      @deploy.repository.should == "honeybadger-read-api"
    end

    it "should have a revision" do
      @deploy.revision.should == "11111" 
    end

    it "should have a environment" do
      @deploy.environment.should == "production"
    end

    it "should have a local_username" do
      @deploy.local_username.should == "deploy" 
    end

    it "should have the date the deploy was made" do
      @deploy.created_at.should == Date.today
    end
  end

  describe "all" do
    it "is pending"
  end

  describe "find" do
    it "is pending"
  end
end