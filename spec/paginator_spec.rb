require 'spec_helper'

describe Honeybadger::Api::Paginator do

  describe "next? and previous?" do
    before :all do
      @client_stub = stub('client')
    end

    describe "when there is one page" do
      before :all do
        opts = {
          :results => [],
          :links => {
            :self => "https://api.honeybadger.io/v2/projects"
          }
        }
        @client_stub.expects(:get).returns(opts)
        Honeybadger::Api.stubs(:client).returns(@client_stub)
        handler = Proc.new { |response| Project.new(response) }

        @paginator = Honeybadger::Api::Paginator.new("projects", {}, handler)
      end

      it "should not have a next page" do
        expect(@paginator.next?).to be_falsey
      end

      it "should not have a previous page" do
        expect(@paginator.previous?).to be_falsey
      end
    end

    describe "when there are two pages and on first page" do
      before :all do
        opts = {
          :results => [],
          :links => {
            :self => "https://api.honeybadger.io/v2/projects",
            :next => "https://api.honeybadger.io/v2/projects?page=2"
          }
        }
        @client_stub.expects(:get).returns(opts)
        Honeybadger::Api.stubs(:client).returns(@client_stub)
        handler = Proc.new { |response| Project.new(response) }

        @paginator = Honeybadger::Api::Paginator.new("projects", {}, handler)
      end

      it "should have a next page" do
        expect(@paginator.next?).to be_truthy
      end

      it "should not have a previous page" do
        expect(@paginator.previous?).to be_falsey
      end
    end

    describe "when there are two pages and on last page" do
      before :all do
        opts = {
          :results => [],
          :links => {
            :self => "https://api.honeybadger.io/v2/projects",
            :prev => "https://api.honeybadger.io/v2/projects?page=1"
          }
        }
        @client_stub.expects(:get).returns(opts)
        Honeybadger::Api.stubs(:client).returns(@client_stub)
        handler = Proc.new { |response| Project.new(response) }

        @paginator = Honeybadger::Api::Paginator.new("projects", {}, handler)
      end

      it "should not have a next page" do
        expect(@paginator.next?).to be_falsey
      end

      it "should have a previous page" do
        expect(@paginator.previous?).to be_truthy
      end
    end

    describe "when there are three pages and on middle page" do
      before :all do
        opts = {
          :results => [],
          :links => {
            :self => "https://api.honeybadger.io/v2/projects",
            :prev => "https://api.honeybadger.io/v2/projects?page=1",
            :next => "https://api.honeybadger.io/v2/projects?page=3"
          }
        }
        @client_stub.expects(:get).returns(opts)
        Honeybadger::Api.stubs(:client).returns(@client_stub)
        handler = Proc.new { |response| Project.new(response) }

        @paginator = Honeybadger::Api::Paginator.new("projects", {}, handler)
      end

      it "should have a next page" do
        expect(@paginator.next?).to be_truthy
      end

      it "should have a previous page" do
        expect(@paginator.previous?).to be_truthy
      end
    end
  end
end
