require 'spec_helper'

describe Honeybadger::Read::Fault do

  describe "initializing a new comment" do
    before :all do
      @fault = FactoryGirl.build :fault
    end

    it "should have a identifier" do
      @fault.id.should == 1
    end

    it "should have a project identifier" do
      @fault.project_id.should == 2
    end

    it "should have an exception klass" do
      @fault.klass.should == "RuntimeError"
    end

    it "should have an action where the fault occurs" do
      @fault.action.should == "runtime_error"
    end

    it "should have a component where the fault occurs" do
      @fault.component.should == "pages"
    end

    it "should have a message" do
      @fault.message.should == "This is a runtime error"
    end

    it "should have an environment" do
      @fault.environment.should == "development"
    end

    it "should have a notice count" do
      @fault.notices_count.should == 7
    end

    it "should have a comment count" do
      @fault.comments_count.should == 0
    end

    it "should have a last notice at" do
      @fault.last_notice_at.should == DateTime.parse("2012-01-01T00:02:00Z")
    end

    it "should have a created_at" do
      @fault.created_at.should == DateTime.parse("2012-01-01T00:01:00Z")
    end
  end

  describe "an ignored fault" do
    before :each do
      @fault = FactoryGirl.build :ignored_fault
    end

    it "should identify the fault as ignored" do
      @fault.ignored?.should be_true
    end
  end

  describe "a resolved fault" do
    before :each do
      @fault = FactoryGirl.build :resolved_fault
    end

    it "should identify the fault as resolved" do
      @fault.resolved?.should be_true
    end
  end

  describe "an unresolved and unignored fault" do
    before :each do
      @fault = FactoryGirl.build :fault
    end

    it "should identify the fault as unresolved" do
      @fault.resolved?.should be_false
    end

    it "should identify the fault as not ignored" do
      @fault.ignored?.should be_false
    end
  end

  describe "all" do
    it "is pending"
  end

  describe "find" do
    before :all do
      @attributes = FactoryGirl.attributes_for(:fault)
      @project_id = 2
      @fault_id = 1

      client_stub = stub('client')
      client_stub.expects(:get).with("projects/#{@project_id}/faults/#{@fault_id}").returns(@attributes)
      Honeybadger::Read.stubs(:client).returns(client_stub)
    end

    it "should find a fault" do
      Honeybadger::Read::Fault.expects(:new).with(@attributes).once
      Honeybadger::Read::Fault.find(@project_id, @fault_id)
    end
  end
end
