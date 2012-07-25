require 'spec_helper'

describe "Project" do
  context "fetching projects from DonorsChoose" do
    describe ".find_by" do
      context "and the query has not been cached in redis" do
      
        before(:each) do
          Redis.any_instance.stub(:get).and_return nil
        end

        it "returns nil" do
          results = Project.find_by(["gradeType=3"])
          results.should be nil
        end
      end

      context "and the query has been cached in redis" do
        before(:each) do
          Redis.any_instance.stub(:get).and_return serve_response(:projects)
        end

        it "returns the cached projects" do
          results = Project.find_by(["gradeType=3"])
          results["proposals"].should_not be nil
        end
      end
    end

    describe ".fetch_and_publish" do
      let(:uri) { Project.build_uri(["state=MN"]) }

      before(:each) do
        Resque.should_receive(:enqueue).with(Fetcher, uri, "123")
      end

      it "queues a resque job" do
        Project.fetch_and_publish(["state=MN"], "123")
      end
    end
  end
end