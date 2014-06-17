describe Honeybadger::Api::Environment do
  describe "initializing a new environment" do
    before :all do
      @environment = FactoryGirl.build :environment
    end

    it "should have an identifier" do
      @environment.id.should == 1
    end

    it "should have a name" do
      @environment.name.should == "production"
    end

    it "should have a project identifier" do
      @environment.project_id.should == 2
    end

    it "should raise notifications" do
      @environment.notifications?.should eql(true)
    end

    it "should have the date the environment was updated" do
      @environment.updated_at.should == DateTime.parse("2012-01-01T00:02:00Z")
    end

    it "should have the date the environment was created" do
      @environment.created_at.should == DateTime.parse("2012-01-01T00:01:00Z")
    end
  end
end