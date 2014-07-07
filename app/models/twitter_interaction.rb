class TwitterInteraction < Interaction
  validate :must_be_connected_to_twitter

  def act(link)
    client.update("#{link.title} #{link.url}")
    # notification success
  rescue Twitter::Error => e
    # add to notifications
    # test if it goes here when no connection
  end

  protected
  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.twitter_api_key
      config.consumer_secret = Rails.application.secrets.twitter_api_secret
      config.access_token = user.twitter_authorization.token
      config.access_token_secret = user.twitter_authorization.secret
    end
  end

  def must_be_connected_to_twitter
    errors.add(:base, "Twitter account has to be assigned to the user before adding interaction.") unless user.has_twitter_access?
  end
end
