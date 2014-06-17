require 'spec_helper'

describe Honeybadger::Read::Team do

  describe "initializing a new team" do
    before :all do
      @team = FactoryGirl.build :team
    end

    it "should have an identifier" do
      @team.id.should == 1
    end

    it "should have a name" do
      @team.name.should == "team"
    end

    it "should have an owner" do
      @team.owner.name.should == "Tom Smith"
      @team.owner.email.should == "tom.smith@example.com"
    end

    it "should have a created_at" do
      @team.created_at.should == DateTime.parse("2012-01-01T00:01:00Z")
    end
  end

  describe "all" do
    before :each do
      @path = "teams"
      @handler = Proc.new { |response| Team.new(response) }
      Honeybadger::Read::Team.expects(:handler).returns(@handler)
    end

    it "should find all of the teams" do
      Honeybadger::Read::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Read::Team.all
    end
  end

  describe "paginate" do
    before :each do
      @path = "teams"
      @handler = Proc.new { |response| Team.new(response) }
      @filters = { some_filter: 'value' }
      Honeybadger::Read::Team.expects(:handler).returns(@handler)
    end

    it "should paginate all of the teams" do
      Honeybadger::Read::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Read::Team.paginate(@filters)
    end
  end

  describe "find" do
    before :each do
      @team_id = 1
      @path = "teams/#{@team_id}"
      @handler = Proc.new { |response| Team.new(response) }
      Honeybadger::Read::Team.expects(:handler).returns(@handler)
    end

    it "should find a team" do
      Honeybadger::Read::Request.expects(:find).with(@path, @handler).once
      Honeybadger::Read::Team.find(@team_id)
    end
  end
end
