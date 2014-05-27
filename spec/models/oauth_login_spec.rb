require 'spec_helper'

describe OauthLogin do
  let(:dummy_oauth_login_class) do
    Class.new do 
      include OauthLogin 
      configure_oauth_login do |access_token| 
        { :token => access_token['token'], :secret => access_token['secret'], :uid => access_token['uid'] }
      end
    end
  end
  let(:access_token) { { 'token' => 't', 'secret' => 's', 'uid' => 123 } }
  let(:user) { User.new(:id => 123) }
  let(:dummy_oauth_login) { dummy_oauth_login_class.new(user, access_token) }
  let(:dummy_oauth_login_without_user) { dummy_oauth_login_class.new(nil, access_token) }

  describe "#user" do
    it "should read" do
      expect(dummy_oauth_login.user.id).to eq 123
    end
  end

  describe "#initialize" do
    it "assigns user" do
      expect(dummy_oauth_login.user.id).to eq 123
    end

    it "creates attributes" do
      attributes = dummy_oauth_login.instance_variable_get(:@authorization_attributes)
      expect(attributes[:uid]).to eq 123
      expect(attributes[:token]).to match 't'
      expect(attributes[:secret]).to match 's'
    end
  end

  describe "#run!" do
    context "when user is signed" do
      it "try to add authorization and return account linked" do
        expect(user).to receive(:add_authorization!)
        expect(dummy_oauth_login.run!).to eq OauthLogin::ACCOUNT_LINKED
      end
    end

    context "when user isn't signed and authorization already exists" do
      let(:authorization) { Authorization.new.tap { |a| a.user = user} }

      it "should assign user and return sign in" do
        expect(Authorization).to receive(:find_by_uid).with('123').and_return authorization
        expect(user).not_to receive(:add_authorization!)
        expect(dummy_oauth_login_without_user.run!).to eq OauthLogin::SIGNED_IN
        expect(dummy_oauth_login_without_user.user).to eq user
      end
    end

    context "when user isn't signed and authorization doesn't exist" do
      it "creates a new user and add authorization" do
        expect(User).to receive(:create!).with(hash_including(:password, :email)).and_return user
        expect(user).to receive(:add_authorization!)
        expect(dummy_oauth_login_without_user.run!).to eq OauthLogin::SIGNED_UP
      end
    end
  end


end
