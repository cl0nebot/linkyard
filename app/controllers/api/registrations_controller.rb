class Api::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token

  respond_to :json

  def create
    user = User.new do |user|
      user.email                 = params[:user][:email]
      user.password              = params[:user][:password]
      user.password_confirmation = params[:user][:password_confirmation]
    end
    if user.save
      sign_in user
      render :status => 200,
           :json => { :success => true,
                      :info => "Registered",
                      :data => { :user => user,
                                 :auth_token => current_user.authentication_token } }
    else
      render :status => :unprocessable_entity,
             :json => { :success => false,
                        :info => user.errors,
                        :data => {} }
    end
  end
end
