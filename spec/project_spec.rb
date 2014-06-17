require 'spec_helper'

describe Honeybadger::Read::Project do

  describe "initializing a new project" do
    before :all do
      @project = FactoryGirl.build :project
    end

    it "should have an identifier" do
      @project.id.should == 1
    end

    it "should have a name" do
      @project.name.should == "Rails"
    end

    it "should have an owner" do
      @project.owner.name.should == "Tom Smith"
      @project.owner.email.should == "tom.smith@example.com"
    end

    it "should have users" do
      @project.users.length.should == 1
      @project.users.first.name.should == "user"
      @project.users.first.email.should == "user@example.com"
    end

    it "should have a token" do
      @project.token.should == "098sflj2"
    end

    it "should have a list of environments" do
      @project.environments.length.should == 1
      @project.environments.first.should be_kind_of(Honeybadger::Read::Environment)
    end

    it "should have a fault count" do
      @project.fault_count.should == 14
    end

    it "should have an unresolved fault count" do
      @project.unresolved_fault_count.should == 1
    end

    it "should have a last notice at" do
      @project.last_notice_at.should == DateTime.parse("2012-01-01T00:02:00Z")
    end

    it "should have a created_at" do
      @project.created_at.should == DateTime.parse("2012-01-01T00:01:00Z")
    end
  end

  describe "an active project" do
    before :each do
      @project = FactoryGirl.build :active_project
    end

    it "should identify the project as active" do
      @project.active?.should be_true
    end

    it "should not identify the project as inactive" do
      @project.inactive?.should be_false
    end
  end

  describe "an inactive project" do
    before :each do
      @project = FactoryGirl.build :inactive_project
    end

    it "should identify the project as inactive" do
      @project.inactive?.should be_true
    end

    it "should not identify the project as active" do
      @project.active?.should be_false
    end
  end

  describe "a public linked project" do
    before :each do
      @project = FactoryGirl.build :public_project
    end

    it "should identify as publicly linked" do
      @project.public_links?.should be_true
    end

    it "should not identify as privately linked" do
      @project.private_links?.should be_false
    end
  end

  describe "a private linked project" do
    before :each do
      @project = FactoryGirl.build :private_project
    end

    it "should identify as privately linked" do
      @project.private_links?.should be_true
    end

    it "should not identify as publicly linked" do
      @project.public_links?.should be_false
    end
  end

  describe "all" do
    before :each do
      @path = "projects"
      @handler = Proc.new { |response| Project.new(response) }
      Honeybadger::Read::Project.expects(:handler).returns(@handler)
    end

    it "should find all of the projects" do
      Honeybadger::Read::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Read::Project.all
    end
  end

  describe "paginate" do
    before :each do
      @path = "projects"
      @handler = Proc.new { |response| Project.new(response) }
      @filters = { some_filter: 'value' }
      Honeybadger::Read::Project.expects(:handler).returns(@handler)
    end

    it "should paginate all of the projects" do
      Honeybadger::Read::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Read::Project.paginate(@filters)
    end
  end

  describe "find" do
    before :each do
      @project_id = 1
      @path = "projects/#{@project_id}"
      @handler = Proc.new { |response| Project.new(response) }
      Honeybadger::Read::Project.expects(:handler).returns(@handler)
    end

    it "should find a project" do
      Honeybadger::Read::Request.expects(:find).with(@path, @handler).once
      Honeybadger::Read::Project.find(@project_id)
    end
  end
end