require 'spec_helper'

describe Honeybadger::Read::Response do

  describe "initializing a new response" do

  end
  describe "next? and previous?" do
    before :all do
      @klass = Honeybadger::Read::Project
    end

    describe "when there is one page" do
      before :all do
        opts = {
          :current_page => 1,
          :num_pages => 1,
          :results => []
        }
        @response = Honeybadger::Read::Response.new(@klass, opts)
      end

      it "should not have a next page" do
        @response.next?.should be_false
      end

      it "should not have a previous page" do
        @response.previous?.should be_false
      end
    end

    describe "when there are two pages and on first page" do
      before :all do
        opts = {
          :current_page => 1,
          :num_pages => 2,
          :results => []
        }
        @response = Honeybadger::Read::Response.new(@klass, opts)
      end

      it "should have a next page" do
        @response.next?.should be_true
      end

      it "should not have a previous page" do
        @response.previous?.should be_false
      end
    end

    describe "when there are two pages and on last page" do
      before :all do
        opts = {
          :current_page => 2,
          :num_pages => 2,
          :results => []
        }
        @response = Honeybadger::Read::Response.new(@klass, opts)
      end

      it "should not have a next page" do
        @response.next?.should be_false
      end

      it "should have a previous page" do
        @response.previous?.should be_true
      end
    end

    describe "when there are three pages and on middle page" do
      before :all do
        opts = {
          :current_page => 2,
          :num_pages => 3,
          :results => []
        }
        @response = Honeybadger::Read::Response.new(@klass, opts)
      end

      it "should have a next page" do
        @response.next?.should be_true
      end

      it "should have a previous page" do
        @response.previous?.should be_true
      end
    end
  end
end
