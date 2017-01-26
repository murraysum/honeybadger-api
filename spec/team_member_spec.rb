require "spec_helper"

describe Honeybadger::Api::TeamMember do

  describe "initializing a new normal team member" do
    before :all do
      @team_member = FactoryGirl.build :normal_team_member
    end

    it "should have an identifier" do
      expect(@team_member.id).to eql(1)
    end

    it "should have a name" do
      expect(@team_member.name).to eql("John Smith")
    end

    it "should have an email address" do
      expect(@team_member.email).to eql("john.smith@example.com")
    end

    it "should have an admin flag" do
      expect(@team_member.admin).to eql(false)
    end

    it "should have the date the team member was created" do
      expect(@team_member.created_at).to eql(DateTime.parse("2012-01-01T00:01:00Z"))
    end
  end

  describe "initializing a new admin team member" do
    before :all do
      @team_member = FactoryGirl.build :admin_team_member
    end

    it "should have an identifier" do
      expect(@team_member.id).to eql(1)
    end

    it "should have a name" do
      expect(@team_member.name).to eql("John Smith")
    end

    it "should have an email address" do
      expect(@team_member.email).to eql("john.smith@example.com")
    end

    it "should have an admin flag" do
      expect(@team_member.admin).to eql(true)
    end

    it "should have the date the team member was created" do
      expect(@team_member.created_at).to eql(DateTime.parse("2012-01-01T00:01:00Z"))
    end
  end

  describe "admin?" do
    it "should be an admin" do
      @team_member = FactoryGirl.build :admin_team_member
      expect(@team_member.admin?).to be_truthy
    end

    it "should not be an admin" do
      @team_member = FactoryGirl.build :normal_team_member
      expect(@team_member.admin?).to be_falsey
    end
  end

  describe "all" do
    before :each do
      @team_id = 1
      @path = "teams/#{@team_id}/team_members"
      @handler = Proc.new { |response| TeamMember.new(response) }
      Honeybadger::Api::TeamMember.expects(:handler).returns(@handler)
    end

    it "should find all of the team members" do
      Honeybadger::Api::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Api::TeamMember.all(@team_id)
    end
  end

  describe "paginate" do
    before :each do
      @team_id = 1
      @path = "teams/#{@team_id}/team_members"
      @handler = Proc.new { |response| TeamMember.new(response) }
      @filters = { some_filter: "value" }
      Honeybadger::Api::TeamMember.expects(:handler).returns(@handler)
    end

    it "should paginate all of the team members" do
      Honeybadger::Api::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Api::TeamMember.paginate(@team_id, @filters)
    end
  end

  describe "find" do
    before :each do
      @team_id = 1
      @team_member_id = 2
      @path = "teams/#{@team_id}/team_members/#{@team_member_id}"
      @handler = Proc.new { |response| TeamMember.new(response) }
      Honeybadger::Api::TeamMember.expects(:handler).returns(@handler)
    end

    it "should find a team member" do
      Honeybadger::Api::Request.expects(:find).with(@path, @handler).once
      Honeybadger::Api::TeamMember.find(@team_id, @team_member_id)
    end
  end
end