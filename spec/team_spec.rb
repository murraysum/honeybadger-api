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

    it "should have members pending"

    it "should have projects pending"

    it "should have a created_at" do
      @team.created_at.should == DateTime.parse("2012-01-01T00:01:00Z")
    end
  end

  describe "all" do
    it "is pending"
  end

  describe "find" do
    before :all do
      @attributes = FactoryGirl.attributes_for(:team)
      @team_id = 1

      client_stub = stub('client')
      client_stub.expects(:get).with("teams/#{@team_id}").returns(@attributes)
      Honeybadger::Read.stubs(:client).returns(client_stub)
    end

    it "should find a team" do
      Honeybadger::Read::Team.expects(:new).with(@attributes).once
      Honeybadger::Read::Team.find(@team_id)
    end
  end
end