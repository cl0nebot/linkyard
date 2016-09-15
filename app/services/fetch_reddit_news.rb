class FetchRedditNews
  RedditLink = Struct.new(:url, :title, :upvotes, :created_at)

  def initialize(subreddit, period)
    @period = period
    @subreddit = subreddit
  end

  def call
    links = RedditKit.links(@subreddit, category: :top, time: @period, limit: 10) || []
    links.map { |l| RedditLink.new(l.url, l.title, l.upvotes, l.created_at) }
  end
end
