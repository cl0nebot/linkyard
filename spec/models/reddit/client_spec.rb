require 'spec_helper'
module Reddit
  describe Client do
    let(:token) { Rails.application.secrets.my_reddit_token }
    let(:refresh_token) { Rails.application.secrets.my_reddit_secret }
    let(:authorization) { Authorization.new(:token => token, :secret => refresh_token) }
    let(:client) do
      Client.new(authorization.token, authorization.secret).tap do |client|
        client.add_token_update_listener { |token| puts "Token updated #{token}" }
      end
    end

    it "should return for tested account" do
      x = client.submit("http://awesome1.io", "Greatest of the greatest tests", "test")
      #x = client.info("http://awesome1.io", "test")
      #x = client.vote("t3_28tuoiaaa", 1) # by jakubgarfield
      #x = client.vote("t3_28y6ri", 0) # by coolcoolnicky
      byebug
    end
  end
end
