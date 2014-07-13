class TwitterOauthLogin < OauthLogin

  def name
    "Twitter"
  end

  protected
  def parse_attributes(access_token)
    {
      :provider => "Twitter",
      :uid => access_token["uid"],
      :name => access_token["info"]["name"],
      :token => access_token["credentials"]["token"],
      :secret => access_token["credentials"]["secret"],
      :first_name => access_token["info"]["first_name"],
      :last_name => access_token["info"]["last_name"],
      :link => access_token["info"]["urls"]["Twitter"]
    }
  end
end

