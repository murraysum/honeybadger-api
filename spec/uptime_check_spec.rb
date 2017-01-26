require "spec_helper"

describe Honeybadger::Api::UptimeCheck do

  describe "initializing a new site" do
    before :all do
      @uptime_check = FactoryGirl.build :uptime_check
    end

    it "should have an up attribute" do
      expect(@uptime_check.up).to be true
    end

    it "should have a location attribute" do
      expect(@uptime_check.location).to eql("Singapore")
    end

    it "should have a duration attribute" do
      expect(@uptime_check.duration).to eql(1201)
    end

    it "should have a created_at attribute" do
      expect(@uptime_check.created_at).to eql(DateTime.parse("2016-06-16T20:19:32.852569Z"))
    end
  end

  describe "all" do
    before :each do
      @project_id = 1
      @site_id = 2
      @path = "projects/#{@project_id}/sites/#{@site_id}/uptime_checks"
      @handler = Proc.new { |response| UptimeCheck.new(response) }
      Honeybadger::Api::UptimeCheck.expects(:handler).returns(@handler)
    end

    it "should find all of the uptime checks" do
      Honeybadger::Api::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Api::UptimeCheck.all(@project_id, @site_id)
    end
  end

  describe "paginate" do
    before :each do
      @project_id = 1
      @site_id = 2
      @path = "projects/#{@project_id}/sites/#{@site_id}/uptime_checks"
      @handler = Proc.new { |response| UptimeCheck.new(response) }
      @filters = { some_filter: "value" }
      Honeybadger::Api::UptimeCheck.expects(:handler).returns(@handler)
    end

    it "should paginate all of the uptime checks" do
      Honeybadger::Api::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Api::UptimeCheck.paginate(@project_id, @site_id, @filters)
    end
  end
end
