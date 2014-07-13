class RedditOauthLogin < OauthLogin

  def name
    "Reddit"
  end

  protected
  def parse_attributes(access_token)
    {
      :provider => name,
      :uid => access_token["uid"],
      :name => access_token["info"]["name"],
      :token => access_token["credentials"]["token"],
      :secret => access_token["credentials"]["refresh_token"],
      :link => "http://www.reddit.com/user/#{access_token["info"]["name"]}"
    }
  end
end

