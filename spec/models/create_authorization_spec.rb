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
        expect(Interaction).not_to receive(:new_by_type)
        act
        expect(user.authorizations.length).to be 1
      end
    end

    context "when doesn't have an authorization yet" do
      let(:interaction) { double() }
      it "should save" do
        allow(interaction).to receive(:user=)
        allow(interaction).to receive(:save!)
        expect(Interaction).to receive(:new_by_type).with("MyFaceInteraction", {}).and_return(interaction)
        act
        expect(User.find(user.id).authorizations.length).to be 1
      end
    end
  end
end
