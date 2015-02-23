require 'rails_helper'

describe User do
  let!(:user) { User.create!(:email => "jo@oh.ny", :password => "12345678", :password_confirmation => "12345678") }
  let(:my_face_authorization) { Authorization.new(:provider => "MyFace") }
  let(:twitter_authorization) { Authorization.new(:provider => "Twitter") }

  describe "#has_authorization_for?" do

    subject { user.has_authorization_for?("MyFace") }

    context "when has no authorizations" do
      it { should eq false }
    end

    context "when has an authorization for provider" do
      before do
        user.authorizations << my_face_authorization
        user.authorizations << twitter_authorization
      end
      it { should eq true }
    end

    context "when doesn't have a right authorization" do
      before { user.authorizations << twitter_authorization }
      it { should eq false }
    end
  end

  describe "#has_twitter_access?" do
    subject { user.has_twitter_access? }

    context "when has a twitter connection" do
      before { user.authorizations << twitter_authorization }
      it { should eq true}
    end

    context "when doesn't have a twitter connection" do
      it { should eq false}
    end
  end

  describe "#twitter_authorization" do
    let(:first_twitter_authorization) { Authorization.new(:provider => "Twitter") }
    let(:second_twitter_authorization) { Authorization.new(:provider => "Twitter") }

    subject { user.twitter_authorization }

    context "when has only one twitter authorization" do
      before { user.authorizations << first_twitter_authorization }
      it "should return this one" do
        expect(subject).to eq first_twitter_authorization
      end
    end

    context "when doesn't have twitter authorization" do
      it { should eq nil }
    end
  end
end
