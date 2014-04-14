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
      @deploy.environment.should be_kind_of(Honeybadger::Read::Environment)
    end

    it "should have a local_username" do
      @deploy.local_username.should == "deploy" 
    end

    it "should have the date the deploy was made" do
      @deploy.created_at.should == DateTime.parse("2012-01-01T00:01:00Z")
    end
  end

  describe "all" do
    it "is pending"
  end

  describe "find" do
    before :all do
      @attributes = FactoryGirl.attributes_for(:deploy)
      @project_id = 1
      @deploy_id = 2

      client_stub = stub('client')
      client_stub.expects(:get).with("projects/#{@project_id}/deploys/#{@deploy_id}").returns(@attributes)
      Honeybadger::Read.stubs(:client).returns(client_stub)
    end

    it "should find a deploy" do
      Honeybadger::Read::Deploy.expects(:new).with(@attributes).once
      Honeybadger::Read::Deploy.find(@project_id, @deploy_id)
    end
  end
end