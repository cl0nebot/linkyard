class FetchRedditNews
  RedditLink = Struct.new(:url, :title, :upvotes, :created_at)
  SUBREDDITS = ["programming", "compsci", "csharp", "dotnet", "elixir", "reactjs", "tea"]

  def initialize(period: :day, limit: 10)
    @period = period
    @limit = limit
  end

  def call
    SUBREDDITS.reduce({}) do |result, subreddit|
      result[subreddit] = client
        .get_top(subreddit, t: @period, limit: @limit)
        .map { |l| RedditLink.new(l.url, l.title, l.ups, DateTime.strptime(l.created_utc.to_s, "%s")) }
      result
    end
  end

  private
  def client
    @client ||= Redd.it(:userless, Rails.application.secrets.reddit_api_key, Rails.application.secrets.reddit_api_secret)
  end
end
