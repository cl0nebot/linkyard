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
      authorization_attributes[:provider].should eq provider
      authorization_attributes[:uid].should eq uid
      authorization_attributes[:token].should eq token
      authorization_attributes[:secret].should eq secret
      authorization_attributes[:first_name].should eq first_name
      authorization_attributes[:last_name].should eq last_name
      authorization_attributes[:link].should eq link
    end
  end
end
