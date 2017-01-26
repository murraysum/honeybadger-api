require "spec_helper"

describe Honeybadger::Api::Outage do

  describe "initializing a new site" do
    before :all do
      @outage = FactoryGirl.build :outage
    end

    it "should have a down_at attribute" do
      expect(@outage.down_at).to eql(DateTime.parse("2015-02-17T18:20:44.776959Z"))
    end

    it "should have an up_at attribute" do
      expect(@outage.up_at).to eql(DateTime.parse("2015-02-17T18:22:35.614678Z"))
    end

    it "should have a created_at attribute" do
      expect(@outage.created_at).to eql(DateTime.parse("2015-02-17T18:20:44.777914Z"))
    end

    it "should have a status attribute" do
      expect(@outage.status).to eql(301)
    end

    it "should have a reason attribute" do
      expect(@outage.reason).to eql("Expected 2xx status code. Got 301")
    end

    it "should have a headers attribute" do
      expected_headers = {
        :date => "Tue, 17 Feb 2015 18:20:44 GMT",
        :server => "DNSME HTTP Redirection",
        :location => "http://text.vote/polls",
        :connection => "close",
        :content_length => "0"
      }
      expect(@outage.headers).to eql(expected_headers)
    end
  end

  describe "all" do
    before :each do
      @project_id = 1
      @site_id = 2
      @path = "projects/#{@project_id}/sites/#{@site_id}/outages"
      @handler = Proc.new { |response| Outage.new(response) }
      Honeybadger::Api::Outage.expects(:handler).returns(@handler)
    end

    it "should find all of the uptime checks" do
      Honeybadger::Api::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Api::Outage.all(@project_id, @site_id)
    end
  end

  describe "paginate" do
    before :each do
      @project_id = 1
      @site_id = 2
      @path = "projects/#{@project_id}/sites/#{@site_id}/outages"
      @handler = Proc.new { |response| Outage.new(response) }
      @filters = { some_filter: "value" }
      Honeybadger::Api::Outage.expects(:handler).returns(@handler)
    end

    it "should paginate all of the uptime checks" do
      Honeybadger::Api::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Api::Outage.paginate(@project_id, @site_id, @filters)
    end
  end
end
