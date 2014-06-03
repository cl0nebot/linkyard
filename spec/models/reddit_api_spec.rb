require 'spec_helper'

describe RedditApi do
  let(:token) { "tSHGPJlbf2ERp6-bLi5movF_Rbg" }
  let(:refresh_token) { "tVmhgVp14syj_qq8iswnUfoDzXs" }
  let(:reddit_api) { RedditApi.new(token, refresh_token) }
  
  describe "#me" do
    it "should return for tested account" do
      puts reddit_api.refresh_access_token   
    end
  end
end
