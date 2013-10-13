require 'spec_helper'

describe Honeybadger::Read::TeamInvitation do
  
  describe "initializing a new team invitation" do
    before :all do
      @team_invitation = FactoryGirl.build :team_invitation
    end

    it "should have a identifier" do
      @team_invitation.id.should == 1 
    end
  end

  describe "all" do
    it "is pending"
  end

  describe "find" do
    it "is pending"
  end

  describe "initializing a list of deploys by mapping attributes" do
    before :all do
      @attribute_collection = [
        FactoryGirl.attributes_for(:team_invitation),
        FactoryGirl.attributes_for(:team_invitation)
      ]
    end

    it "should map the attributes to a list of team invitation instances" do
      Honeybadger::Read::TeamInvitation.expects(:map).with(@attribute_collection.first).once
      Honeybadger::Read::TeamInvitation.expects(:map).with(@attribute_collection.last).once
      Honeybadger::Read::TeamInvitation.map_collection(@attribute_collection)
    end
  end

  describe "initializing a new team invitation by mapping attributes" do
    before :all do
      @attributes = FactoryGirl.attributes_for(:team_invitation)
    end

    it "should map the attributes to new team member instance" do
      Honeybadger::Read::TeamInvitation.expects(:new).with(
        @attributes[:id],
        @attributes[:token],
        @attributes[:email],
        @attributes[:created_by],
        @attributes[:accepted_by],
        @attributes[:admin],
        @attributes[:created_at],
        @attributes[:accepted_at],
        @attributes[:message]
      ).once
      Honeybadger::Read::TeamInvitation.map(@attributes)
    end
  end
end