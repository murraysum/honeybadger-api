require "spec_helper"

describe Honeybadger::Api::Environment do
  describe "initializing a new environment" do
    before :all do
      @environment = FactoryGirl.build :environment
    end

    it "should have an identifier" do
      expect(@environment.id).to eql(1)
    end

    it "should have a name" do
      expect(@environment.name).to eql("production")
    end

    it "should have a project identifier" do
      expect(@environment.project_id).to eql(2)
    end

    it "should raise notifications" do
      expect(@environment.notifications?).to be_truthy
    end

    it "should have the date the environment was updated" do
      expect(@environment.updated_at).to eql(DateTime.parse("2012-01-01T00:02:00Z"))
    end

    it "should have the date the environment was created" do
      expect(@environment.created_at).to eql(DateTime.parse("2012-01-01T00:01:00Z"))
    end
  end
end