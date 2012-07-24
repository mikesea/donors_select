require 'spec_helper'

describe "ProjectsCountsController" do
  describe "#index" do

    let(:uri) { Project.build_uri }
    let(:projects) { serve_response(:projects) }

    context "fetching counts that have been cached" do

      before(:each) do
        Project.stub(:find_by).and_return JSON.parse(projects)
        get projects_counts_url(format: :json)
      end

      it "returns a count of projects" do
        response_json = JSON.parse(response.body)
        response_json["count"].should_not be nil
        response_json["count"].class.should be Fixnum
      end
    end

    context "fetching projects that haven't been cached" do
      before(:each) do
        Project.stub(:find_by).and_return nil
        get projects_counts_url(format: :json)
      end

      it "returns an empty hash" do
        response_json = JSON.parse(response.body)
        response_json.should be {}
      end
    end
  end

end