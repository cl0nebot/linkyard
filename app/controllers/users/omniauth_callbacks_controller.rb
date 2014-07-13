class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    authenticate(TwitterOauthLogin.new(current_user, access_token("twitter")))
  end

  def reddit
    authenticate(RedditOauthLogin.new(current_user, access_token("reddit")))
  end

  protected
  def access_token(provider)
    session["devise.#{provider}_data"] = env["omniauth.auth"].except("extra")
  end

  def authenticate(login)
    case login.run!
    when OauthLogin::ACCOUNT_LINKED
      redirect_to edit_user_registration_path
    when OauthLogin::SIGNED_IN, OauthLogin::SIGNED_UP
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => login.name
      sign_in_and_redirect login.user, :event => :authentication
    end
  end
end
