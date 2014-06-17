require 'spec_helper'

describe Honeybadger::Api::Comment do

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
    before :each do
      @project_id = 1
      @fault_id = 2
      @path = "projects/#{@project_id}/faults/#{@fault_id}/comments"
      @handler = Proc.new { |response| Comment.new(response) }
      Honeybadger::Api::Comment.expects(:handler).returns(@handler)
    end

    it "should find all of the comments" do
      Honeybadger::Api::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Api::Comment.all(@project_id, @fault_id)
    end
  end

  describe "paginate" do
    before :each do
      @project_id = 1
      @fault_id = 2
      @path = "projects/#{@project_id}/faults/#{@fault_id}/comments"
      @handler = Proc.new { |response| Comment.new(response) }
      @filters = { some_filter: 'value' }
      Honeybadger::Api::Comment.expects(:handler).returns(@handler)
    end

    it "should paginate all of the comments" do
      Honeybadger::Api::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Api::Comment.paginate(@project_id, @fault_id, @filters)
    end
  end

  describe "find" do
    before :each do
      @project_id = 1
      @fault_id = 2
      @comment_id = 3
      @path = "projects/#{@project_id}/faults/#{@fault_id}/comments/#{@comment_id}"
      @handler = Proc.new { |response| Comment.new(response) }
      Honeybadger::Api::Comment.expects(:handler).returns(@handler)
    end

    it "should find a comment" do
      Honeybadger::Api::Request.expects(:find).with(@path, @handler).once
      Honeybadger::Api::Comment.find(@project_id, @fault_id, @comment_id)
    end
  end
end