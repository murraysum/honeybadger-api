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
      @comment.created_at.should == Date.today
    end
  end

  describe "all" do
    it "is pending"
  end

  describe "find" do
    before :all do
      @attributes = FactoryGirl.attributes_for(:comment)
    end
    
    it "should map the attributes to a new comment instance" do
      client_stub = stub('client')
      client_stub.expects(:get).returns(@attributes)
      Honeybadger::Read.stubs(:client).returns(client_stub)
      Honeybadger::Read::Comment.expects(:map).with(@attributes).once
      Honeybadger::Read::Comment.find(@project_id, @fault_id, @comment_id)
    end
  end

  describe "initializing a list of comments by mapping attributes" do
    before :all do
      @attribute_collection = [
        FactoryGirl.attributes_for(:comment),
        FactoryGirl.attributes_for(:comment)
      ]
    end

    it "should map the attributes to a list of comment instances" do
      Honeybadger::Read::Comment.expects(:map).with(@attribute_collection.first).once
      Honeybadger::Read::Comment.expects(:map).with(@attribute_collection.last).once
      Honeybadger::Read::Comment.map_collection(@attribute_collection)
    end
  end

  describe "initializing a new comment by mapping attributes" do
    before :all do
      @attributes = FactoryGirl.attributes_for(:comment)
    end

    it "should map the attributes to new comment instance" do
      Honeybadger::Read::Comment.expects(:new).with(
        @attributes[:id],
        @attributes[:fault_id],
        @attributes[:event],
        @attributes[:source],
        @attributes[:notices_count],
        @attributes[:author],
        @attributes[:body],
        @attributes[:created_at]
      ).once
      Honeybadger::Read::Comment.map(@attributes)
    end
  end
end