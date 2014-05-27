require 'spec_helper'

describe User do
  let!(:user) { User.create!(:email => "j@oh.ny", :password => "12345678", :password_confirmation => "12345678") }
  let(:my_face_authorization) { Authorization.new(:provider => "MyFace") }
  let(:twitter_authorization) { Authorization.new(:provider => "Twitter") }

  describe "#has_authorization_for?" do

    subject { user.has_authorization_for?("MyFace") }

    context "when has no authorizations" do
      it { should be_false }
    end

    context "when has an authorization for provider" do
      before do
        user.authorizations << my_face_authorization
        user.authorizations << twitter_authorization
      end 
      it { should be_true }
    end

    context "when doesn't have a right authorization" do
      before { user.authorizations << twitter_authorization }
      it { should be_false }
    end
  end

  describe "#add_authorization!" do
    def act
      user.add_authorization!(:provider => "MyFace" )
    end
    
    context "when has an authorization already" do
      before { user.authorizations << my_face_authorization }
      it "shouldn't save anything" do
        act
        expect(user.authorizations.length).to be 1
      end
    end

    context "when doesn't have an authorization yet" do
      it "should save" do
        act
        expect(User.find(user.id).authorizations.length).to be 1
      end
    end
  end

  describe "#has_twitter_access?" do
    subject { user.has_twitter_access? }

    context "when has a twitter connection" do
      before { user.authorizations << twitter_authorization }
      it { should be_true}
    end

    context "when doesn't have a twitter connection" do
      it { should be_false}
    end
  end

  describe "#twitter_authorization" do
    let(:first_twitter_authorization) { Authorization.new(:id => 1, :provider => "Twitter") }
    let(:second_twitter_authorization) { Authorization.new(:id => 2, :provider => "Twitter") }

    subject { user.twitter_authorization }

    context "when has multiple twitter authorizations" do
      before do
        user.authorizations << first_twitter_authorization
        user.authorizations << second_twitter_authorization
      end
      it "should return the latest one" do
        expect(subject.id).to eq 2
      end
    end

    context "when has only one twitter authorization" do
      before { user.authorizations << first_twitter_authorization }
      it "should return this one" do
        expect(subject.id).to eq 1
      end
    end

    context "when doesn't have twitter authorization" do
      it { should be_nil }
    end
  end
end
