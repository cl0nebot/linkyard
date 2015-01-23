require 'spec_helper'

describe Api::RegistrationsController do
  include Devise::TestHelpers

  describe "POST 'create'" do
    before { @request.env["devise.mapping"] = Devise.mappings[:user] }

    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, user: {email: 'bob@email.com', password: 'password', password_confirmation: 'password'}
        }.to change(User, :count).by(1)
        body = JSON.parse(response.body)
        expect(body.keys).to match_array(["success", "info", "data"])
        expect(body['data']['user'].keys).to match_array(["id", "created_at", "updated_at", "email", "authentication_token"])
        expect(body['data']['user']['email']).to eq('bob@email.com')
        expect(response).to be_success
      end
    end

    context "with invalid params" do
      it "fails and returns an error message" do
        expect {
          post :create, user: {email: 'bob@email.com', password: '', password_confirmation: ''}
        }.to_not change(User, :count).by(1)
        expect(JSON.parse(response.body)).to eq({
          "data" => {},
          "info" => {"password"=>["can't be blank"]},
          "success" => false
        })
        expect(response).to_not be_success
      end
    end
  end
end
