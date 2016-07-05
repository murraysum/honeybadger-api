require 'spec_helper'

describe Honeybadger::Api::Fault do

  describe "initializing a new comment" do
    before :all do
      @fault = FactoryGirl.build :fault
    end

    it "should have a identifier" do
      expect(@fault.id).to eql(1)
    end

    it "should have a project identifier" do
      expect(@fault.project_id).to eql(2)
    end

    it "should have an exception klass" do
      expect(@fault.klass).to eql("RuntimeError")
    end

    it "should have an action where the fault occurs" do
      expect(@fault.action).to eql("runtime_error")
    end

    it "should have a component where the fault occurs" do
      expect(@fault.component).to eql("pages")
    end

    it "should have a message" do
      expect(@fault.message).to eql("This is a runtime error")
    end

    it "should have an environment" do
      expect(@fault.environment).to eql("production")
    end

    it "should have a notice count" do
      expect(@fault.notices_count).to eql(7)
    end

    it "should have a comment count" do
      expect(@fault.comments_count).to eql(0)
    end

    it "should have a last notice at" do
      expect(@fault.last_notice_at).to eql(DateTime.parse("2012-01-01T00:02:00Z"))
    end

    it "should have a created_at" do
      expect(@fault.created_at).to eql(DateTime.parse("2012-01-01T00:01:00Z"))
    end

    it "should have a url" do
      expect(@fault.url).to eql("https://app.honeybadger.io/projects/2/faults/1")
    end

    it "should not have an assignee" do
      expect(@fault.assignee).to be_nil
    end

    it "should have tags" do
      expect(@fault.tags).to eql(["internal"])
    end

    it "should have a deploy object" do
      expect(@fault.deploy).to_not be_nil
    end
  end

  describe "an ignored fault" do
    before :each do
      @fault = FactoryGirl.build :ignored_fault
    end

    it "should identify the fault as ignored" do
      expect(@fault.ignored?).to be_truthy
    end
  end

  describe "a resolved fault" do
    before :each do
      @fault = FactoryGirl.build :resolved_fault
    end

    it "should identify the fault as resolved" do
      expect(@fault.resolved?).to be_truthy
    end
  end

  describe "an assigned fault" do
    before :each do
      @fault = FactoryGirl.build :assigned_fault
    end

    it "should have an assigned name" do
      expect(@fault.assignee.name).to eql("Tom Smith")
    end

    it "should have an assigned email" do
      expect(@fault.assignee.email).to eql("tom.smith@example.com")
    end
  end

  describe "an unresolved and unignored fault" do
    before :each do
      @fault = FactoryGirl.build :fault
    end

    it "should identify the fault as unresolved" do
      expect(@fault.resolved?).to be_falsey
    end

    it "should identify the fault as not ignored" do
      expect(@fault.ignored?).to be_falsey
    end
  end

  describe "all" do
    before :each do
      @project_id = 1
      @path = "projects/#{@project_id}/faults"
      @handler = Proc.new { |response| Fault.new(response) }
      Honeybadger::Api::Fault.expects(:handler).returns(@handler)
    end

    it "should find all of the faults" do
      Honeybadger::Api::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Api::Fault.all(@project_id)
    end
  end

  describe "paginate" do
    before :each do
      @project_id = 1
      @path = "projects/#{@project_id}/faults"
      @handler = Proc.new { |response| Fault.new(response) }
      @filters = { some_filter: 'value' }
      Honeybadger::Api::Fault.expects(:handler).returns(@handler)
    end

    it "should paginate all of the faults" do
      Honeybadger::Api::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Api::Fault.paginate(@project_id, @filters)
    end
  end

  describe "find" do
    before :each do
      @project_id = 1
      @fault_id = 2
      @path = "projects/#{@project_id}/faults/#{@fault_id}"
      @handler = Proc.new { |response| Fault.new(response) }
      Honeybadger::Api::Fault.expects(:handler).returns(@handler)
    end

    it "should find a fault" do
      Honeybadger::Api::Request.expects(:find).with(@path, @handler).once
      Honeybadger::Api::Fault.find(@project_id, @fault_id)
    end
  end
end