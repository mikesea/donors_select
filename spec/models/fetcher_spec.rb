require 'spec_helper'

describe "Fetcher" do
  context "retrieving projects from Redis" do
    describe ".perform" do
      let(:uri) { Project.build_uri(["state=MN"]) }
      let(:user_token) { "xcjk1234" }
      let(:projects) { serve_response(:projects) }
      let(:parsed_json) { JSON.parse(projects).to_json }

      before(:each) do
        Net::HTTP.any_instance.stub(:get).and_return projects
        Redis.should_receive(:set).with(uri, parsed_json)
        Fetcher.should_receive(:publish).with(parsed_json, user_token)
      end

      it "retrieves the projects from DonorsChoose and sets the value in Redis" do
        Redis.any_instance.stub(:get).and_return nil
        Fetcher.perform(uri, user_token)
      end
    end
  end
end