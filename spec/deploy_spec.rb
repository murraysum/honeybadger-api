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
      @deploy.created_at.should == DateTime.parse("2012-01-01T00:01:00Z")
    end
  end

  describe "all" do
    before :each do
      @project_id = 1
      @path = "projects/#{@project_id}/deploys"
      @handler = Proc.new { |response| Deploy.new(response) }
      Honeybadger::Read::Deploy.expects(:handler).returns(@handler)
    end

    it "should find all of the deploys" do
      Honeybadger::Read::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Read::Deploy.all(@project_id)
    end
  end

  describe "paginate" do
    before :each do
      @project_id = 1
      @path = "projects/#{@project_id}/deploys"
      @handler = Proc.new { |response| Deploy.new(response) }
      @filters = { some_filter: 'value' }
      Honeybadger::Read::Deploy.expects(:handler).returns(@handler)
    end

    it "should paginate all of the deploys" do
      Honeybadger::Read::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Read::Deploy.paginate(@project_id, @filters)
    end
  end

  describe "find" do
    before :each do
      @project_id = 1
      @deploy_id = 2
      @path = "projects/#{@project_id}/deploys/#{@deploy_id}"
      @handler = Proc.new { |response| Deploy.new(response) }
      Honeybadger::Read::Deploy.expects(:handler).returns(@handler)
    end

    it "should find a deploy" do
      Honeybadger::Read::Request.expects(:find).with(@path, @handler).once
      Honeybadger::Read::Deploy.find(@project_id, @deploy_id)
    end
  end
end