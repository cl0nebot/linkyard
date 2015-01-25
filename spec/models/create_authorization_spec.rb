require 'spec_helper'

describe CreateAuthorization do
  let!(:user) { User.create!(:email => "j@oh.ny", :password => "12345678", :password_confirmation => "12345678") }
  let(:my_face_authorization) { Authorization.new(:provider => "MyFace") }
  let(:twitter_authorization) { Authorization.new(:provider => "Twitter") }

  describe "#call!" do
    def act
      CreateAuthorization.new(user, { :provider => "MyFace" }).call
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
end
