require 'spec_helper'

describe Honeybadger::Read::Integration do
  describe "initializing a new integration" do
    before :all do
      @integration = FactoryGirl.build :integration
    end

    it "should have a name" do
      @integration.name.should == "Github"
    end

    it "should have an integration identifier" do
      @integration.integration_id.should == "rails/rails"
    end
  end
end