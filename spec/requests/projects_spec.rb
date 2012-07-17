require 'spec_helper'

describe "Projects" do
  describe "#index" do
    context "fetching an unfiltered set of projects" do

      before(:each) do
        Net::HTTP.stub(:get).and_return serve_response(:projects)
        get projects_url(format: :json)
      end

      it "returns a set of projects" do
        response_json = JSON.parse(response.body)
        response_json.should_not be nil
      end
    end
  end

end