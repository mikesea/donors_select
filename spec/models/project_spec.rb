require 'spec_helper'

describe "Project" do
  context "fetching projects from DonorsChoose" do
    describe ".build_uri" do

      it "builds a valid URI when no params are specified" do
        uri = Project.build_uri
        uri.should == "http://api.donorschoose.org/common/json_feed.html?APIKey=DONORSCHOOSE"
      end

      it "builds a valid URI when params are specified" do
        params = ["gradeType=3"]
        uri = Project.build_uri(params)
        uri.should == "http://api.donorschoose.org/common/json_feed.html?gradeType=3&APIKey=DONORSCHOOSE"
      end
    end

    describe ".find_by" do
      
      before(:each) do
        Net::HTTP.stub(:get).and_return serve_response(:projects)
      end

      it "returns propsals from DonorsChoose" do
        results = Project.find_by(["gradeType=3"])
        results["proposals"].should_not be nil
      end

    end
  end
end