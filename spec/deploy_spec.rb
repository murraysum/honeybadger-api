require 'spec_helper'

describe Honeybadger::Api::Deploy do
  
  describe "initializing a new deploy" do
    before :all do
      @deploy = FactoryGirl.build :deploy
    end

    it "should have a identifier" do
      expect(@deploy.id).to eql(1)
    end

    it "should have a url" do
      expect(@deploy.url).to eql("https://github.com/murraysum/honeybadger-api/compare/1cf2e67...c128731")
    end

    it "should have a project identifier" do
      expect(@deploy.project_id).to eql(2)
    end

    it "should have a repository" do
      expect(@deploy.repository).to eql("honeybadger-api")
    end

    it "should have a revision" do
      expect(@deploy.revision).to eql("11111")
    end

    it "should have a environment" do
      expect(@deploy.environment).to eql("production")
    end

    it "should have a changelog" do
      expect(@deploy.changelog).to eql(["New release"])
    end

    it "should have a local_username" do
      expect(@deploy.local_username).to eql("deploy")
    end

    it "should have the date the deploy was made" do
      expect(@deploy.created_at).to eql(DateTime.parse("2012-01-01T00:01:00Z"))
    end
  end

  describe "all" do
    before :each do
      @project_id = 1
      @path = "projects/#{@project_id}/deploys"
      @handler = Proc.new { |response| Deploy.new(response) }
      Honeybadger::Api::Deploy.expects(:handler).returns(@handler)
    end

    it "should find all of the deploys" do
      Honeybadger::Api::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Api::Deploy.all(@project_id)
    end
  end

  describe "paginate" do
    before :each do
      @project_id = 1
      @path = "projects/#{@project_id}/deploys"
      @handler = Proc.new { |response| Deploy.new(response) }
      @filters = { some_filter: 'value' }
      Honeybadger::Api::Deploy.expects(:handler).returns(@handler)
    end

    it "should paginate all of the deploys" do
      Honeybadger::Api::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Api::Deploy.paginate(@project_id, @filters)
    end
  end

  describe "find" do
    before :each do
      @project_id = 1
      @deploy_id = 2
      @path = "projects/#{@project_id}/deploys/#{@deploy_id}"
      @handler = Proc.new { |response| Deploy.new(response) }
      Honeybadger::Api::Deploy.expects(:handler).returns(@handler)
    end

    it "should find a deploy" do
      Honeybadger::Api::Request.expects(:find).with(@path, @handler).once
      Honeybadger::Api::Deploy.find(@project_id, @deploy_id)
    end
  end
end