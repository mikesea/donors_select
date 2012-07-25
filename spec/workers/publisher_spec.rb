require 'spec_helper'

describe "Publisher" do
  context "publishing projects via Pusher" do
    describe ".perform" do
      
      let(:projects) { JSON.parse(serve_response(:projects)) }
      let(:user_token) { "asdf1234"}

      it "publishes a project via pusher" do
        Pusher[user_token].should_receive(:trigger)
        Publisher.perform(projects, user_token)
      end
    end
  end
end
