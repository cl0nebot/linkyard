require 'spec_helper'

describe RedditClient do
  let(:token) { "JwqSnG3F1cjh_AENXDvG3rUNx7o" }
  let(:refresh_token) { "tVmhgVp14syj_qq8iswnUfoDzXs" }
  let(:authorization) { Authorization.new(:token => token, :secret => secret) }
  let(:connection) { RedditConnection.new(authorization.token, authorization.secret, :on_token_update => authorization) }
  let(:client) { RedditClient.new(connection) }
  
  describe "#me" do
    it "should return for tested account" do
      puts client.me
    end
  end
end
