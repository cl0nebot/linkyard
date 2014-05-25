require 'spec_helper'

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
      'extra' => {
        'raw_info' => {
          'id' => uid,
          'name' => name
        }
      },
      'credentials' => {
        'token' => token,
        'secret' => secret
      },
      'info' => {
        'first_name' => first_name,
        'last_name' => last_name
      }
    }
  end


  it "creates authorization attributes and assigns correct values" do
    authorization_attributes = login.instance_variable_get(:@authorization_attributes)
    authorization_attributes[:provider].should eq provider
    authorization_attributes[:uid].should eq uid
    authorization_attributes[:token].should eq token
    authorization_attributes[:secret].should eq secret
    authorization_attributes[:first_name].should eq first_name
    authorization_attributes[:last_name].should eq last_name
    authorization_attributes[:link].should eq link
  end  

  describe "#name" do
    it "equals to name of the provider" do
      login.name.should eq provider
    end
  end
end
