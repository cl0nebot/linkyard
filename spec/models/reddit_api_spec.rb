require 'spec_helper'

describe RedditApi do
  #let(:token) { "tSHGPJlbf2ERp6-bLi5movF_Rbg" }
  let(:token) { "JwqSnG3F1cjh_AENXDvG3rUNx7o" }
  let(:refresh_token) { "tVmhgVp14syj_qq8iswnUfoDzXs" }
  let(:reddit_api) { RedditApi.new(token, refresh_token) }
  
  describe "#me" do
    it "should return for tested account" do
      puts reddit_api.me  
    end
  end
end
