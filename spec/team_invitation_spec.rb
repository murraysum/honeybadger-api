require 'spec_helper'

describe Honeybadger::Read::TeamInvitation do
  
  describe "initializing a new team invitation" do
    before :all do
      @team_invitation = FactoryGirl.build :team_invitation
    end

    it "should have a identifier" do
      @team_invitation.id.should == 1
    end

    it "should have a token" do
      @team_invitation.token.should == "e62394d2"
    end

    it "should have an email" do
      @team_invitation.email.should == "invitation@example.com"
    end

    it "should have an accepted at date" do
      @team_invitation.accepted_at.should == Date.today
    end

    it "should have a created at date" do
      @team_invitation.created_at.should == Date.today
    end

    it "should have a invitation message" do
      @team_invitation.message.should == "Come join in"
    end
  end

  describe "an admin team invitation" do
    before :each do
      @team_invitation = FactoryGirl.build :admin_team_invitation
    end

    it "should identify as an admin invitation" do
      @team_invitation.admin?.should be_true
    end
  end

  describe "a normal team invitation" do
    before :each do
      @team_invitation = FactoryGirl.build :team_invitation
    end

    it "should not identify as an admin invitation" do
      @team_invitation.admin?.should be_false
    end
  end

  describe "all" do
    it "is pending"
  end

  describe "find" do
    before :each do
      @attributes = FactoryGirl.attributes_for(:team_invitation)
      @team_id = 1
      @team_invitation_id = 2

      client_stub = stub('client')
      client_stub.expects(:get).with("teams/#{@team_id}/team_invitations/#{@team_invitation_id}").returns(@attributes)
      Honeybadger::Read.stubs(:client).returns(client_stub)
    end

    it "should find a team invitation" do
      Honeybadger::Read::TeamInvitation.expects(:new).with(@attributes).once
      Honeybadger::Read::TeamInvitation.find(@team_id, @team_invitation_id)
    end
  end
end