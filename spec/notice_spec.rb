require 'spec_helper'

describe Honeybadger::Api::Notice do

  describe "initializing a new comment" do
    before :all do
      @notice = FactoryGirl.build :notice
    end

    it "should have a identifier" do
      @notice.id.should == 1
    end

    it "should have a fault identifier" do
      @notice.fault_id.should == 2
    end

    it "should have a message" do
      @notice.message.should == "This is a runtime error"
    end

    it "should have an environment" do
      @notice.environment.should be_kind_of(Honeybadger::Api::Environment)
    end

    it "should have a request" do
      @notice.request.empty?.should == false
    end

    it "should have a created_at" do
      @notice.created_at.should == DateTime.parse("2012-01-01T00:01:00Z")
    end
  end

  describe "all" do
    before :each do
      @project_id = 1
      @fault_id = 2
      @path = "projects/#{@project_id}/faults/#{@fault_id}/notices"
      @handler = Proc.new { |response| Notice.new(response) }
      Honeybadger::Api::Notice.expects(:handler).returns(@handler)
    end

    it "should find all of the notices" do
      Honeybadger::Api::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Api::Notice.all(@project_id, @fault_id)
    end
  end

  describe "paginate" do
    before :each do
      @project_id = 1
      @fault_id = 2
      @path = "projects/#{@project_id}/faults/#{@fault_id}/notices"
      @handler = Proc.new { |response| Notice.new(response) }
      @filters = { some_filter: 'value' }
      Honeybadger::Api::Notice.expects(:handler).returns(@handler)
    end

    it "should paginate all of the notices" do
      Honeybadger::Api::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Api::Notice.paginate(@project_id, @fault_id, @filters)
    end
  end

  describe "find" do
    before :each do
      @project_id = 1
      @fault_id = 2
      @notice_id = 3
      @path = "projects/#{@project_id}/faults/#{@fault_id}/notices/#{@notice_id}"
      @handler = Proc.new { |response| Notice.new(response) }
      Honeybadger::Api::Notice.expects(:handler).returns(@handler)
    end

    it "should find a notice" do
      Honeybadger::Api::Request.expects(:find).with(@path, @handler).once
      Honeybadger::Api::Notice.find(@project_id, @fault_id, @notice_id)
    end
  end
end
