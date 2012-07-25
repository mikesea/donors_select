require 'spec_helper'

class DummyClass
	include BuildUri
end

describe "BuildUri" do
	let(:dummy){ DummyClass.new }

  context "fetching projects from DonorsChoose" do
		describe ".build_uri" do

		  it "builds a valid URI when no params are specified" do
		    uri = dummy.build_uri
		    uri.should == "http://api.donorschoose.org/common/json_feed.html?max=20&APIKey=DONORSCHOOSE"
		  end

		  it "builds a valid URI when params are specified" do
		    params = ["gradeType=3"]
		    uri = dummy.build_uri(params)
		    uri.should == "http://api.donorschoose.org/common/json_feed.html?max=20&APIKey=DONORSCHOOSE&gradeType=3"
		  end
		end
	end
end