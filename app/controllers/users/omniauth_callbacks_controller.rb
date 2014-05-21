class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    access_token = env["omniauth.auth"]

    uid = access_token['extra']['raw_info']['id']
    name = access_token['extra']['raw_info']['name']
    authorization_attributes = { 
      :uid => uid, 
      :token => access_token['credentials']['token'],
      :secret => access_token['credentials']['secret'], 
      :first_name => access_token['info']['first_name'],
      :last_name => access_token['info']['last_name'], 
      :name => name,
      :link => "http://twitter.com/#{name}",
      :provider => "Twitter"
    }

    unless current_user.authorizations.exists?(:provider => "Twitter")
      current_user.authorizations.build(authorization_attributes)
      current_user.save!
      session["devise.twitter_data"] = access_token
    end

    redirect_to edit_user_registration_path 
  end
end
