require 'rails_helper'

describe TwitterOauthLogin do
  let(:current_user) { nil }
  let(:uid) { 123 }
  let(:token) { "johny's token" }
  let(:secret) { "johny's secret" }
  let(:first_name) { "Johny" }
  let(:last_name) { "Smith" }
  let(:name) { "@johnysmith" }
  let(:link) { "http://twitter.com/#{name}" }
  let(:provider) { "Twitter" }
  let(:login) { TwitterOauthLogin.new(current_user, access_token) }
  let(:access_token) do
    {
      'uid' => uid,
      'credentials' => {
        'token' => token,
        'secret' => secret
      },
      'info' => {
        'name' => name,
        'first_name' => first_name,
        'last_name' => last_name,
        'urls' => { "Twitter" => link }
      }
    }
  end

  describe ".new" do
    it "should assign correct authorization attributes" do
      authorization_attributes = login.authorization_attributes
      expect(authorization_attributes[:provider]).to eq provider
      expect(authorization_attributes[:uid]).to eq uid
      expect(authorization_attributes[:token]).to eq token
      expect(authorization_attributes[:secret]).to eq secret
      expect(authorization_attributes[:first_name]).to eq first_name
      expect(authorization_attributes[:last_name]).to eq last_name
      expect(authorization_attributes[:link]).to eq link
    end
  end
end
