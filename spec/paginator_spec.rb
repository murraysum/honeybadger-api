require 'spec_helper'

describe Honeybadger::Read::Paginator do

  describe "initializing a new paginator" do

  end

  describe "next? and previous?" do
    before :all do
      @client_stub = stub('client')
    end

    describe "when there is one page" do
      before :all do
        opts = {
          :current_page => 1,
          :num_pages => 1,
          :results => []
        }
        @client_stub.expects(:get).returns(opts)
        Honeybadger::Read.stubs(:client).returns(@client_stub)
        handler = Proc.new { |response| Project.new(response) }

        @paginator = Honeybadger::Read::Paginator.new("projects", {}, handler)
      end

      it "should not have a next page" do
        @paginator.next?.should be_false
      end

      it "should not have a previous page" do
        @paginator.previous?.should be_false
      end
    end

    describe "when there are two pages and on first page" do
      before :all do
        opts = {
          :current_page => 1,
          :num_pages => 2,
          :results => []
        }
        @client_stub.expects(:get).returns(opts)
        Honeybadger::Read.stubs(:client).returns(@client_stub)
        handler = Proc.new { |response| Project.new(response) }

        @paginator = Honeybadger::Read::Paginator.new("projects", {}, handler)
      end

      it "should have a next page" do
        @paginator.next?.should be_true
      end

      it "should not have a previous page" do
        @paginator.previous?.should be_false
      end
    end

    describe "when there are two pages and on last page" do
      before :all do
        opts = {
          :current_page => 2,
          :num_pages => 2,
          :results => []
        }
        @client_stub.expects(:get).returns(opts)
        Honeybadger::Read.stubs(:client).returns(@client_stub)
        handler = Proc.new { |response| Project.new(response) }

        @paginator = Honeybadger::Read::Paginator.new("projects", {}, handler)
      end

      it "should not have a next page" do
        @paginator.next?.should be_false
      end

      it "should have a previous page" do
        @paginator.previous?.should be_true
      end
    end

    describe "when there are three pages and on middle page" do
      before :all do
        opts = {
          :current_page => 2,
          :num_pages => 3,
          :results => []
        }
        @client_stub.expects(:get).returns(opts)
        Honeybadger::Read.stubs(:client).returns(@client_stub)
        handler = Proc.new { |response| Project.new(response) }

        @paginator = Honeybadger::Read::Paginator.new("projects", {}, handler)
      end

      it "should have a next page" do
        @paginator.next?.should be_true
      end

      it "should have a previous page" do
        @paginator.previous?.should be_true
      end
    end
  end
end
