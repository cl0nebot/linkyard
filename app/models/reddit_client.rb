class RedditClient 
  def initialize(connection)
    @connection = connection
  end

  def submit(link, title, subreddit)
  end


  def vote
  end

  def me
    @connection.get("me")
  end
end
