class TwitterInteraction < Interaction
  attr_accessor :consumer_key
  attr_accessor :consumer_secret
  attr_accessor :access_token
  attr_accessor :access_token_secret

  validates :consumer_key, :consumer_secret, :access_token, :access_token_secret, :presence => true
  store :configuration, :accessors => [:consumer_key, :consumer_secret, :access_token, :access_token_secret]
end
