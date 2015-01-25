class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, unless: :json_request?
  before_action :authenticate_user_from_token!
  before_action :authenticate_user!

  private

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def authenticate_user_from_token!
    user_token = params[:auth_token].presence
    user       = user_token && User.find_by_authentication_token(user_token.to_s)

    if user
      sign_in user, store: false
    end
  end

  def json_request?
    request.format.json?
  end
end
