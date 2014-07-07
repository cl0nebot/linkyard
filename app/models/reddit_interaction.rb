class RedditInteraction < Interaction
  before_validation :must_be_connected_to_reddit

  def act(link)
    subreddit = "test"
    submission = client.submit(link.url, link.title, subreddit)
    if submission.success?
      # notification success
    elsif submission.already_submitted?
      info = client.info(link.url, subreddit).items.first
      client.vote(info.id, 1)
      # notification success with upvote
    else
      # notification error
    end
  rescue Reddit::ResponseError => e
    # notification error
    # test if it goes here when no connection
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
        client.add_token_update_listener do |token|
          user.reddit_authorization.secret = token
          user.reddit_authorization.save!
        end
      end
  end
end
