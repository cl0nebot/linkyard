require 'spec_helper'

describe Reddit::Client do
  let(:token) { "LwrnI1CASDiVdQKPwndDuWVOmGk" }
  let(:refresh_token) { "RsMgyyn_1DFAngHHUTM8axcapEA" }
  let(:authorization) { Authorization.new(:token => token, :secret => refresh_token) }
  let(:client) do
    Reddit::Client.new(authorization.token, authorization.secret).tap do |client|
      client.add_token_update_listener { |token| puts "Token updated #{token}" }
    end
  end
  
  describe "#me" do
    it "should return for tested account" do
      me = client.me
      #puts client.needs_captcha?
      #puts client.submit("http://awesome.io", "Greatest of the greatest tests", "test")
    end
  end
end
