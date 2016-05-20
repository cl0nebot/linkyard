class Tweet
  def initalize(text, user, digest_type)
    @text = text
    @user = user
    @digest_type = digest_type
  end

  def call
    client.update(@text)
  end

  private
  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.twitter_api_key
      config.consumer_secret = Rails.application.secrets.twitter_api_secret
      config.access_token = @user.twitter_authorization(@digest_type).token
      config.access_token_secret = @user.twitter_authorization(@digest_type).secret
    end
  end
end
