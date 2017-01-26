require "spec_helper"

describe Honeybadger::Api::Site do

  describe "initializing a new site" do
    before :all do
      @site = FactoryGirl.build :site
    end

    it "should have an id attribute" do
      expect(@site.id).to eql("9eed6a7e-af77-4cc6-8c55-b7b17555330d")
    end

    it "should have an active attribute" do
      expect(@site.active).to be true
    end

    it "should have a frequency attribute" do
      expect(@site.frequency).to eql(5)
    end

    it "should have a last_checked_at attribute" do
      expect(@site.last_checked_at).to eql(DateTime.parse("2016-06-15T12:57:29.646956Z"))
    end

    it "should have a match attribute" do
      expect(@site.match).to be_nil
    end

    it "should have a match_type attribute" do
      expect(@site.match_type).to eql("success")
    end

    it "should have a name attribute" do
      expect(@site.name).to eql("Main site")
    end

    it "should have a state attribute" do
      expect(@site.state).to eql("down")
    end

    it "should have an url attribute" do
      expect(@site.url).to eql("http://www.example.com")
    end
  end

  describe "all" do
    before :each do
      @project_id = 1
      @path = "projects/#{@project_id}/sites"
      @handler = Proc.new { |response| Site.new(response) }
      Honeybadger::Api::Site.expects(:handler).returns(@handler)
    end

    it "should find all of the sites" do
      Honeybadger::Api::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Api::Site.all(@project_id)
    end
  end

  describe "paginate" do
    before :each do
      @project_id = 1
      @path = "projects/#{@project_id}/sites"
      @handler = Proc.new { |response| Site.new(response) }
      @filters = { some_filter: 'value' }
      Honeybadger::Api::Site.expects(:handler).returns(@handler)
    end

    it "should paginate all of the sites" do
      Honeybadger::Api::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Api::Site.paginate(@project_id, @filters)
    end
  end

  describe "find" do
    before :each do
      @project_id = 1
      @site_id = 2
      @path = "projects/#{@project_id}/sites/#{@site_id}"
      @handler = Proc.new { |response| Site.new(response) }
      Honeybadger::Api::Site.expects(:handler).returns(@handler)
    end

    it "should find a site" do
      Honeybadger::Api::Request.expects(:find).with(@path, @handler).once
      Honeybadger::Api::Site.find(@project_id, @site_id)
    end
  end
end
