class TwitterInteraction < Interaction
  validate :must_be_connected_to_twitter

  def act(link_interaction)
    client_for(link_interaction.link.digest).update("#{link_interaction.link.title} #{link_interaction.link.url} #{ tags_to_hashtag_list(link_interaction.link.tags) }")
    link_interaction.update_and_notify!(:success, "submitted")
  rescue Twitter::Error => e
    link_interaction.update_and_notify!(:error, e.message)
  end

  protected
  def client_for(digest)
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.twitter_api_key
      config.consumer_secret = Rails.application.secrets.twitter_api_secret
      config.access_token = user.twitter_authorization(digest).token
      config.access_token_secret = user.twitter_authorization(digest).secret
    end
  end

  def must_be_connected_to_twitter
    errors.add(:base, "Twitter account has to be assigned to the user before adding interaction.") unless user.has_twitter_access?
  end

  def tags_to_hashtag_list(tags)
    tags.map { |t| "#" + t.name }.join(" ")
  end
end
