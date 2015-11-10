Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.secrets.twitter_api_key, Rails.application.secrets.twitter_api_secret
  provider :reddit, Rails.application.secrets.reddit_api_key, Rails.application.secrets.reddit_api_secret, :scope => "identity,read,vote,submit", :duration => "permanent"
  provider :buffer, Rails.application.secrets.buffer_api_key, Rails.application.secrets.buffer_api_secret
end
