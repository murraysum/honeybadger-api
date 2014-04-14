require 'spec_helper'

describe Honeybadger::Read::Notice do

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
      @notice.environment.should be_kind_of(Honeybadger::Read::Environment)
    end

    it "should have a request" do
      @notice.request.empty?.should == false
    end

    it "should have a created_at" do
      @notice.created_at.should == DateTime.parse("2012-01-01T00:01:00Z")
    end
  end

  describe "all" do
    it "is pending"
  end

  describe "find" do
    before :all do
      @attributes = FactoryGirl.attributes_for(:notice)
      @project_id = 3
      @fault_id = 2
      @notice_id = 1
      client_stub = stub('client')
      client_stub.expects(:get).with("projects/#{@project_id}/faults/#{@fault_id}/notices/#{@notice_id}").returns(@attributes)
      Honeybadger::Read.stubs(:client).returns(client_stub)
    end

    it "should find a fault" do
      Honeybadger::Read::Notice.expects(:new).with(@attributes).once
      Honeybadger::Read::Notice.find(@project_id, @fault_id, @notice_id)
    end
  end
end