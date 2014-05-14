class TwitterInteraction < Interaction
  validates :consumer_key, :consumer_secret, :access_token, :access_token_secret, :presence => true
  store_accessor :configuration, :consumer_key, :consumer_secret, :access_token, :access_token_secret
end
