class TwitterInteraction < Interaction
  validates :access_token, :access_token_secret, :presence => true
  store_accessor :configuration, :access_token, :access_token_secret
  before_validation :assign_twitter_credentials

  def act(link)
    client = create_twitter_client
    client.update("#{link.title} #{link.url}")
  end

  protected
  def create_twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.twitter_api_key
      config.consumer_secret = Rails.application.secrets.twitter_api_secret
      config.access_token = access_token
      config.access_token_secret = access_token_secret
    end
  end

  def assign_twitter_credentials
    authorization = user.authorizations.where(:provider => "Twitter").first
    self.access_token = authorization.token
    self.access_token_secret = authorization.secret    
  end
end
