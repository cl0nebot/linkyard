class RedditClient 
  def initialize(token, refresh_token, on_token_update = nil)
    @connection = RedditConnection.new(token, refresh_token, on_token_update)
  end

  def submit(link, title, subreddit)
  end


  def vote
  end

  def me
    @connection.get("me")
  end
end
