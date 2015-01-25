require 'spec_helper'

describe Api::SessionsController do
  include Devise::TestHelpers
  let!(:user) { User.create(email: 'bob@email.com', password: 'password', password_confirmation: 'password') }

  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  describe "POST 'create'" do
    context "with valid input from an existing user" do
      it "creates a new User" do
        post :create, user: {email: user.email, password: user.password}
        expect(JSON.parse(response.body)).to eq(
          {
            "success" => true,
            "info" => "Logged in",
            "data" => {
              "auth_token" => user.authentication_token
            }
          }
        )
        expect(response).to be_success
      end
    end

    context "with invalid input" do
      it "does not login the user" do
        post :create, user: {email: user.email, password: ''}
        expect(JSON.parse(response.body)).to eq(
          {
            "data" => {},
            "info" => "Login Failed",
            "success" => false
          }
        )
        expect(response).to_not be_success
      end
    end
  end

  describe "DELETE 'destroy'" do
    context "when the user's current authentication_token is submitted" do
      it "logs the user out" do
        delete :destroy, auth_token: user.authentication_token
        expect(JSON.parse(response.body)).to eq(
          {
            "data" => {},
            "info" => "Logged out",
            "success" => true
          }
        )
        expect(response).to be_success
      end
    end

    context "without the user's authentication_token" do
      it "does not logout the user" do
        post :destroy, auth_token: ''
        expect(JSON.parse(response.body)).to eq(
          {
            "data" => {},
            "info" => "Login Failed",
            "success" => false
          }
        )
        expect(response).to_not be_success
      end
    end
  end
end
