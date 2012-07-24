require 'spec_helper'

describe "Fetcher" do
  
  let(:uri) { Project.build_uri }
  let(:user_token) { "asdf1234"}
  let(:projects) { serve_response(:projects) }

  describe ".perform" do

    context "the query is not cached in redis" do

      before(:each) do
        Fetcher.stub(:is_set?).and_return false
        Fetcher.stub(:fetch_projects).and_return projects
      end

      it "sets the value in redis, and queues a Resque job to publish" do
        Redis.any_instance.should_receive(:set)
        Fetcher.should_receive(:publish).with(uri, user_token)
        Fetcher.perform(uri, user_token)
      end
    end

    context "the query is cached in redis" do

      before(:each) do
        Fetcher.stub(:is_set?).and_return true
        Fetcher.stub(:fetch_projects).and_return projects
      end

      it "does not set the value in redis, but queues a job to publish" do
        Redis.any_instance.should_not_receive(:set)
        Fetcher.should_receive(:publish).with(uri, user_token)
        Fetcher.perform(uri, user_token)
      end
    end
  end

  describe ".is_set?" do
    it "returns true if the value is set in redis" do
      Redis.any_instance.stub_chain(:keys, :include?).and_return true
      Fetcher.is_set?(:a_set_key).should be
    end

    it "returns false if the value is not set in redis" do
      Redis.any_instance.stub_chain(:keys, :include?).and_return false
      Fetcher.is_set?(:a_not_set_key).should be false
    end
  end

  describe ".fetch_projects" do
    
    it "returns a Hash of proposals from the DonorsChoose API" do
      Net::HTTP.stub(:get).and_return serve_response(:projects)
      Fetcher.fetch_projects(uri).class.should == Hash
    end
  end

  describe ".publish" do
    
    before(:each) do
      Redis.any_instance.stub(:get).and_return projects
      Resque.should_receive(:enqueue).with(Publisher, JSON.parse(projects), user_token)
    end

    it "queues a Publisher job" do
      Fetcher.publish(uri, user_token)
    end
  end
end