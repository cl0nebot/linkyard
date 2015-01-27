class RedditInteraction < Interaction
  before_validation :must_be_connected_to_reddit

  def act(link_interaction)
    link = link_interaction.link
    default_tag = link.default_tag

    if default_tag.nil?
      link_interaction.update_and_notify!(:error, "Default tag is missing")
      return
    end

    submission = client.submit(link.url, link.title, default_tag.name)
    if submission.success?
      link_interaction.update_and_notify!(:success, "submitted")
    elsif submission.already_submitted?
      info = client.info(link.url, subreddit).items.first
      client.vote(info.id, 1)
      link_interaction.update_and_notify!(:success, "upvoted")
    else
      link_interaction.update_and_notify!(:error, submission.errors.join(", "))
    end
  rescue Reddit::ResponseError => e
    link_interaction.update_and_notify!(:error, e.message)
  rescue SocketError => e
    link_interaction.update_and_notify!(:error, e.message)
  end

  protected
  def must_be_connected_to_reddit
    errors.add(:base, "Reddit account has to be assigned to the user before adding interaction.") unless user.has_reddit_access?
  end

  def client
    @client ||= Reddit::Client.new(Rails.application.secrets.reddit_api_key,
      Rails.application.secrets.reddit_api_secret,
      user.reddit_authorization.token,
      user.reddit_authorization.secret).tap do |client|
        client.add_token_update_listener { |token| user.reddit_authorization.update!(:token => token) }
      end
  end
end
