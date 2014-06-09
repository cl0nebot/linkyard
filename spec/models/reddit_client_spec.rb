require 'spec_helper'

describe RedditClient do
  let(:token) { "JwqSnG3F1cjh_AENXDvG3rUNx7o" }
  let(:refresh_token) { "tVmhgVp14syj_qq8iswnUfoDzXs" }
  let(:authorization) { Authorization.new(:token => token, :secret => refresh_token) }
  let(:client) { RedditClient.new(authorization.token, authorization.secret, -> (token) { puts token }) }
  
  describe "#me" do
    it "should return for tested account" do
      puts client.me
    end
  end
end
