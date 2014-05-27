class TwitterOauthLogin
  include OauthLogin

  configure_oauth_login do |access_token|
    {
      :provider => "Twitter",
      :uid => access_token['extra']['raw_info']['id'],
      :name => access_token['extra']['raw_info']['name'],
      :token => access_token['credentials']['token'],
      :secret => access_token['credentials']['secret'], 
      :first_name => access_token['info']['first_name'],
      :last_name => access_token['info']['last_name'], 
      :link => "http://twitter.com/#{access_token['extra']['raw_info']['name']}" 
    }
  end
end

