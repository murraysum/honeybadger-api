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

  describe "initializing a list of deploys by mapping attributes" do
    before :all do
      @attribute_collection = [
        FactoryGirl.attributes_for(:deploy),
        FactoryGirl.attributes_for(:deploy)
      ]
    end

    it "should map the attributes to a list of deploy instances" do
      Honeybadger::Read::Deploy.expects(:map).with(@attribute_collection.first).once
      Honeybadger::Read::Deploy.expects(:map).with(@attribute_collection.last).once
      Honeybadger::Read::Deploy.map_collection(@attribute_collection)
    end
  end

  describe "initializing a new deploy by mapping attributes" do
    before :all do
      @attributes = FactoryGirl.attributes_for(:deploy)
      @deploy = Honeybadger::Read::Deploy.map(@attributes)
    end

    it "should map the attributes to new team member instance" do
      Honeybadger::Read::Deploy.expects(:new).with(
        @attributes[:id],
        @attributes[:project_id],
        @attributes[:repository],
        @attributes[:revision],
        @attributes[:environment],
        @attributes[:local_username],
        @attributes[:created_at]
      ).once
      Honeybadger::Read::Deploy.map(@attributes)
    end
  end
end