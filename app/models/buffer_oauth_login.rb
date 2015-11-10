class BufferOauthLogin < OauthLogin
  def name
    "Buffer"
  end

  def parse_attributes(access_token)
    {
      provider: "Buffer",
      uid: access_token.uid,
      token: access_token.credentials.token,
    }
  end
end
