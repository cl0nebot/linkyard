class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    provider = "Twitter"
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
      :provider => provider
    }

    session["devise.twitter_data"] = access_token
    
    if user_signed_in?
      current_user.add_authorization!(authorization_attributes)
      redirect_to edit_user_registration_path 
    else
      if auth = Authorization.find_by_uid(uid.to_s)
        user = auth.user
      else
        user = User.create!(:password => Devise.friendly_token[0,20], :email => "#{UUIDTools::UUID.random_create}@linkyard.me")
        user.add_authorization!(authorization_attributes)
      end

      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider
      sign_in_and_redirect user, :event => :authentication
    end
  end

end
