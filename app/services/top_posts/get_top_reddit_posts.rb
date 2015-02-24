
class TopPosts::GetTopRedditPosts
  POST_COUNT = 1000

  include HTTParty
  base_uri 'https://www.reddit.com/r/programming/top.json'

  def initialize
    @last_post_downloaded = nil
    @posts = []
  end

  def call
    until @posts.size >= POST_COUNT
      get_posts
    end

    @posts
  end

  private

  def get_posts
    response = self.class.get("", :query => request_options)
    response_json = JSON.parse(response.body)['data']

    @last_post_downloaded = response_json['after']

    posts = response_json['children']
    @posts += posts.map { |post_json| RedditPost.new(post_json['data']) }
  end

  class RedditPost
    attr_reader :score, :created_at
    def initialize(json)
      @score = json['score'].to_i
      @created_at = Time.at(json['created_utc'])
    end
  end

  def create_reddit_post(json)
    RedditPost.new(json)
  end

  def request_options
    options = {
      t: 'month',
      limit: 100,
    }

    if @last_post_downloaded
      options['after'] = @last_post_downloaded
      options['count'] = @posts.size
    end

    options
  end
end
