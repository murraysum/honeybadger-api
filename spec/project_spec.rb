require 'spec_helper'

describe Honeybadger::Api::Project do

  describe "initializing a new project" do
    before :all do
      @project = FactoryGirl.build :project
    end

    it "should have an identifier" do
      expect(@project.id).to eql(1)
    end

    it "should have a name" do
      expect(@project.name).to eql("Rails")
    end

    it "should have an owner" do
      expect(@project.owner.name).to eql("Tom Smith")
      expect(@project.owner.email).to eql("tom.smith@example.com")
    end

    it "should have users" do
      expect(@project.users.length).to eql(1)
      expect(@project.users.first.name).to eql("user")
      expect(@project.users.first.email).to eql("user@example.com")
    end

    it "should have a token" do
      expect(@project.token).to eql("098sflj2")
    end

    it "should have a list of environments" do
      expect(@project.environments.length).to eql(1)
      expect(@project.environments.first).to be_kind_of(Honeybadger::Api::Environment)
    end

    it "should have a fault count" do
      expect(@project.fault_count).to eql(14)
    end

    it "should have an unresolved fault count" do
      expect(@project.unresolved_fault_count).to eql(1)
    end

    it "should have a last notice at" do
      expect(@project.last_notice_at).to eql(DateTime.parse("2012-01-01T00:02:00Z"))
    end

    it "should have a created_at" do
      expect(@project.created_at).to eql(DateTime.parse("2012-01-01T00:01:00Z"))
    end
  end

  describe "an active project" do
    before :each do
      @project = FactoryGirl.build :active_project
    end

    it "should identify the project as active" do
      expect(@project.active?).to be_true
    end

    it "should not identify the project as inactive" do
      expect(@project.inactive?).to be_false
    end
  end

  describe "an inactive project" do
    before :each do
      @project = FactoryGirl.build :inactive_project
    end

    it "should identify the project as inactive" do
      expect(@project.inactive?).to be_true
    end

    it "should not identify the project as active" do
      expect(@project.active?).to be_false
    end
  end

  describe "a public linked project" do
    before :each do
      @project = FactoryGirl.build :public_project
    end

    it "should identify as publicly linked" do
      expect(@project.public_links?).to be_true
    end

    it "should not identify as privately linked" do
      expect(@project.private_links?).to be_false
    end
  end

  describe "a private linked project" do
    before :each do
      @project = FactoryGirl.build :private_project
    end

    it "should identify as privately linked" do
      expect(@project.private_links?).to be_true
    end

    it "should not identify as publicly linked" do
      expect(@project.public_links?).to be_false
    end
  end

  describe "all" do
    before :each do
      @path = "projects"
      @handler = Proc.new { |response| Project.new(response) }
      Honeybadger::Api::Project.expects(:handler).returns(@handler)
    end

    it "should find all of the projects" do
      Honeybadger::Api::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Api::Project.all
    end
  end

  describe "paginate" do
    before :each do
      @path = "projects"
      @handler = Proc.new { |response| Project.new(response) }
      @filters = { some_filter: 'value' }
      Honeybadger::Api::Project.expects(:handler).returns(@handler)
    end

    it "should paginate all of the projects" do
      Honeybadger::Api::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Api::Project.paginate(@filters)
    end
  end

  describe "find" do
    before :each do
      @project_id = 1
      @path = "projects/#{@project_id}"
      @handler = Proc.new { |response| Project.new(response) }
      Honeybadger::Api::Project.expects(:handler).returns(@handler)
    end

    it "should find a project" do
      Honeybadger::Api::Request.expects(:find).with(@path, @handler).once
      Honeybadger::Api::Project.find(@project_id)
    end
  end
end