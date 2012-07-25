require 'spec_helper'

describe "Project" do
  context "fetching projects from DonorsChoose" do
    describe ".find_by" do
      context "and the query has not been cached" do
      
        before(:each) do
          Project.stub(:fetch_projects).and_return nil
        end

        it "returns nil" do
          results = Project.find_by(["gradeType=3"])
          results.should be nil
        end
      end

      context "and the query has been cached" do
        before(:each) do
          Project.stub(:fetch_projects).and_return serve_response(:projects)
        end

        it "returns the cached projects" do
          results = Project.find_by(["gradeType=3"])
          results["proposals"].should_not be nil
        end
      end
    end

    describe ".fetch_and_publish" do
      let(:uri) { Project.build_uri(["state=MN"]) }

      it "calls queue job with the uri and token" do
        Project.should_receive(:queue_fetch_job).with(uri, "123")
        Project.fetch_and_publish(["state=MN"], "123")
      end
    end

    describe ".fetch_projects" do
      let(:uri) { Project.build_uri(["state=MN"]) }

      it "calls redis.get with the uri" do
        Redis.any_instance.should_receive(:get).with(uri)
        Project.fetch_projects(uri)
      end
    end

    describe ".queue_fetch_job" do
      let(:uri) { Project.build_uri(["state=MN"]) }

      it "calls Resque.enqueue with the uri and token" do
        Resque.should_receive(:enqueue).with(Fetcher, uri, "123")
        Project.queue_fetch_job(uri, "123")
      end
    end
  end
end