require 'spec_helper'

describe Honeybadger::Read::Comment do

  describe "initializing a new comment" do
    before :all do
      @comment = FactoryGirl.build :comment
    end

    it "should have a identifier" do
      @comment.id.should == 1 
    end

    it "should have a fault identifier" do
      @comment.fault_id.should == 2 
    end

    it "should have an event" do
      @comment.event.should == "an event"
    end

    it "should have a source" do
      @comment.source.should == "app" 
    end

    it "should have a notice count" do
      @comment.notices_count.should == 5 
    end

    it "should have an author" do
      @comment.author.should == "John" 
    end

    it "should have a body" do
      @comment.body.should == "This is a comment" 
    end

    it "should have the date the comment was created" do
      @comment.created_at.should == DateTime.parse("2012-01-01T00:01:00Z")
    end
  end

  describe "all" do
    it "is pending"
  end

  describe "find" do
    before :all do
      @attributes = FactoryGirl.attributes_for(:comment)
      @project_id = 1
      @fault_id = 2
      @comment_id = 3

      client_stub = stub('client')
      client_stub.expects(:get).with("projects/#{@project_id}/faults/#{@fault_id}/comments/#{@comment_id}").returns(@attributes)
      Honeybadger::Read.stubs(:client).returns(client_stub)
    end

    it "should map the attributes to a new comment instance" do
      Honeybadger::Read::Comment.expects(:new).with(@attributes).once
      Honeybadger::Read::Comment.find(@project_id, @fault_id, @comment_id)
    end
  end
end