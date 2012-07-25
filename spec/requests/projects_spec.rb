require 'spec_helper'

describe "ProjectsController" do
  describe "#index" do

    let(:uri) { Project.build_uri }
    let(:projects) { serve_response(:projects) }

    context "fetching projects that have been cached" do

      before(:each) do
        Project.stub(:find_by).and_return JSON.parse(projects)
        get projects_url(format: :json)
      end

      it "returns a set of projects" do
        response_json = JSON.parse(response.body)
        response_json.should_not be nil
      end
    end

    context "fetching projects that haven't been cached" do
      before(:each) do
        Project.stub(:find_by).and_return nil
        Resque.should_receive(:enqueue)
        get projects_url(format: :json)
      end

      it "returns no projects and queues a job to fetch them" do
        response_json = JSON.parse(response.body)
        response_json.should be {}
      end
    end
  end
end