require "spec_helper"

describe Honeybadger::Api::Team do

  describe "initializing a new team" do
    before :all do
      @team = FactoryGirl.build :team
    end

    it "should have an identifier" do
      expect(@team.id).to eql(1)
    end

    it "should have a name" do
      expect(@team.name).to eql("team")
    end

    it "should have an owner" do
      expect(@team.owner.name).to eql("Tom Smith")
      expect(@team.owner.email).to eql("tom.smith@example.com")
    end

    it "should have a created_at" do
      expect(@team.created_at).to eql(DateTime.parse("2012-01-01T00:01:00Z"))
    end
  end

  describe "all" do
    before :each do
      @path = "teams"
      @handler = Proc.new { |response| Team.new(response) }
      Honeybadger::Api::Team.expects(:handler).returns(@handler)
    end

    it "should find all of the teams" do
      Honeybadger::Api::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Api::Team.all
    end
  end

  describe "paginate" do
    before :each do
      @path = "teams"
      @handler = Proc.new { |response| Team.new(response) }
      @filters = { some_filter: "value" }
      Honeybadger::Api::Team.expects(:handler).returns(@handler)
    end

    it "should paginate all of the teams" do
      Honeybadger::Api::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Api::Team.paginate(@filters)
    end
  end

  describe "find" do
    before :each do
      @team_id = 1
      @path = "teams/#{@team_id}"
      @handler = Proc.new { |response| Team.new(response) }
      Honeybadger::Api::Team.expects(:handler).returns(@handler)
    end

    it "should find a team" do
      Honeybadger::Api::Request.expects(:find).with(@path, @handler).once
      Honeybadger::Api::Team.find(@team_id)
    end
  end
end
