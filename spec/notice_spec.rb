require 'spec_helper'

describe Honeybadger::Api::Notice do

  describe "initializing a new comment" do
    before :all do
      @notice = FactoryGirl.build :notice
    end

    it "should have a identifier" do
      expect(@notice.id).to eql("5a24f938-a578-427d-a92b-d2f134d4af67")
    end

    it "should have a url" do
      expect(@notice.url).to eql("https://app.honeybadger.io/projects/1404/faults/2/5a24f938-a578-427d-a92b-d2f134d4af67")
    end

    it "should have a fault identifier" do
      expect(@notice.fault_id).to eql(2)
    end

    it "should have a message" do
      expect(@notice.message).to eql("This is a runtime error")
    end

    it "should have an environment" do
      environment = {
        :project_root => "/data/www/apps/myapp/releases/20160701085636",
        :environment_name => "production",
        :hostname => "web1.myapp.com",
        :pid => 22587
      }
      expect(@notice.environment).to eql(environment)
    end

    it "should have an environment_name" do
      expect(@notice.environment_name).to eql("production")
    end

    it "should have cookies" do
      expect(@notice.cookies).to eql({:cookie => "monster"})
    end

    it "should have a web environment" do
      web_environment = {
        :REMOTE_ADDR => "127.0.0.1",
        :REQUEST_METHOD => "POST"
      }
      expect(@notice.web_environment).to eql(web_environment)
    end

    it "should have a backtrace" do
      backtrace = [
        {
          :number => "21",
          :file => "[PROJECT_ROOT]/lib/multivariate/participation/cookie_participation.rb",
          :method => "[]"
        },
        {
          :number => "21",
          :file => "[PROJECT_ROOT]/lib/multivariate/participation/cookie_participation.rb",
          :method => "get_existing_data"
        }
      ]
      expect(@notice.backtrace).to eql(backtrace)
    end

    it "should have a request" do
      expect(@notice.request.empty?).to be_falsey
    end

    it "should have a created_at" do
      expect(@notice.created_at).to eql(DateTime.parse("2012-01-01T00:01:00Z"))
    end
  end

  describe "all" do
    before :each do
      @project_id = 1
      @fault_id = 2
      @path = "projects/#{@project_id}/faults/#{@fault_id}/notices"
      @handler = Proc.new { |response| Notice.new(response) }
      Honeybadger::Api::Notice.expects(:handler).returns(@handler)
    end

    it "should find all of the notices" do
      Honeybadger::Api::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Api::Notice.all(@project_id, @fault_id)
    end
  end

  describe "paginate" do
    before :each do
      @project_id = 1
      @fault_id = 2
      @path = "projects/#{@project_id}/faults/#{@fault_id}/notices"
      @handler = Proc.new { |response| Notice.new(response) }
      @filters = { some_filter: 'value' }
      Honeybadger::Api::Notice.expects(:handler).returns(@handler)
    end

    it "should paginate all of the notices" do
      Honeybadger::Api::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Api::Notice.paginate(@project_id, @fault_id, @filters)
    end
  end

  describe "find" do
    before :each do
      @project_id = 1
      @fault_id = 2
      @notice_id = "5a24f938-a578-427d-a92b-d2f134d4af67"
      @path = "projects/#{@project_id}/faults/#{@fault_id}/notices/#{@notice_id}"
      @handler = Proc.new { |response| Notice.new(response) }
      Honeybadger::Api::Notice.expects(:handler).returns(@handler)
    end

    it "should find a notice" do
      Honeybadger::Api::Request.expects(:find).with(@path, @handler).once
      Honeybadger::Api::Notice.find(@project_id, @fault_id, @notice_id)
    end
  end
end
