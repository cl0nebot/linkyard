require 'spec_helper'

describe Reddit::Client do
  let(:token) { "f25KHUtOjzsd00FcUB-kZUioNhs" }
  let(:refresh_token) { "RsMgyyn_1DFAngHHUTM8axcapEA" }
  let(:authorization) { Authorization.new(:token => token, :secret => refresh_token) }
  let(:client) { Reddit::Client.new(authorization.token, authorization.secret, -> (token) { puts "Token updated #{token}" }) }
  
  describe "#me" do
    it "should return for tested account" do
      me = client.me
      byebug
      #puts client.needs_captcha?
      #puts client.submit("http://awesome.io", "Greatest of the greatest tests", "test")
    end
  end
end
