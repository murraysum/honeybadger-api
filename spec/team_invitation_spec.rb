require 'spec_helper'

describe Honeybadger::Api::TeamInvitation do
  
  describe "initializing a new team invitation" do
    before :all do
      @team_invitation = FactoryGirl.build :team_invitation
    end

    it "should have a identifier" do
      expect(@team_invitation.id).to eql(1)
    end

    it "should have a token" do
      expect(@team_invitation.token).to eql("e62394d2")
    end

    it "should have an email" do
      expect(@team_invitation.email).to eql("invitation@example.com")
    end

    it "should have an accepted_at date" do
      expect(@team_invitation.accepted_at).to eql(DateTime.parse("2012-01-01T00:02:00Z"))
    end

    it "should have a created_at date" do
      expect(@team_invitation.created_at).to eql(DateTime.parse("2012-01-01T00:01:00Z"))
    end

    it "should have a invitation message" do
      expect(@team_invitation.message).to eql("Come join in")
    end
  end

  describe "an admin team invitation" do
    before :each do
      @team_invitation = FactoryGirl.build :admin_team_invitation
    end

    it "should identify as an admin invitation" do
      expect(@team_invitation.admin?).to be_truthy
    end
  end

  describe "a normal team invitation" do
    before :each do
      @team_invitation = FactoryGirl.build :team_invitation
    end

    it "should not identify as an admin invitation" do
      expect(@team_invitation.admin?).to be_falsey
    end
  end

  describe "all" do
    before :each do
      @team_id = 1
      @path = "teams/#{@team_id}/team_invitations"
      @handler = Proc.new { |response| TeamInvitation.new(response) }
      Honeybadger::Api::TeamInvitation.expects(:handler).returns(@handler)
    end

    it "should find all of the team invitations" do
      Honeybadger::Api::Request.expects(:all).with(@path, @handler).once
      Honeybadger::Api::TeamInvitation.all(@team_id)
    end
  end

  describe "paginate" do
    before :each do
      @team_id = 1
      @path = "teams/#{@team_id}/team_invitations"
      @handler = Proc.new { |response| TeamInvitation.new(response) }
      @filters = { some_filter: 'value' }
      Honeybadger::Api::TeamInvitation.expects(:handler).returns(@handler)
    end

    it "should paginate all of the team invitations" do
      Honeybadger::Api::Request.expects(:paginate).with(@path, @handler, @filters).once
      Honeybadger::Api::TeamInvitation.paginate(@team_id, @filters)
    end
  end

  describe "find" do
    before :each do
      @team_id = 1
      @team_invitation_id = 2
      @path = "teams/#{@team_id}/team_invitations/#{@team_invitation_id}"
      @handler = Proc.new { |response| TeamInvitation.new(response) }
      Honeybadger::Api::TeamInvitation.expects(:handler).returns(@handler)
    end

    it "should find a team invitation" do
      Honeybadger::Api::Request.expects(:find).with(@path, @handler).once
      Honeybadger::Api::TeamInvitation.find(@team_id, @team_invitation_id)
    end
  end
end