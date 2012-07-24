require 'spec_helper'

describe "Publisher" do
  context "publishing projects via Pusher" do
    describe ".perform" do
      
      let(:projects) { JSON.parse(serve_response(:projects)) }
      let(:user_token) { "asdf1234"}

      before(:each) do
        Pusher[user_token].should_receive(:trigger)
      end

      it "publishes a project via pusher" do
        Publisher.perform(projects, user_token)
      end
    end
  end
end