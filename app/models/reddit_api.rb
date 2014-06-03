class RedditApi 

  AUTHENTICATION_URI = "https://ssl.reddit.com/api/v1/"
  API_URI = "https://oauth.reddit.com/api/v1/"

  def initialize(token, refresh_token)
    @token = token
    @refresh_token = refresh_token
  end

  def submit(link, title, subreddit)
  end

  def refresh_access_token
    post("access_token", { "grant_type" => "refresh_token", "refresh_token" => @refresh_token }, AUTHENTICATION_URI)
  end

  def vote
  end

  def me
    get "me"
  end

  private
  def get(method, api = API_URI)   
    uri = URI(api + method)
    req = Net::HTTP::Get.new(uri)
    req['Authorization'] = "bearer #{@token}"
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
    res.body
  end

  def post(method, data, api = API_URI)
    uri = URI(api + method)
    req = Net::HTTP::Post.new(uri)
    req.set_form_data(data)
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
    res.body
  end

  def authorization_header
    { "Authorization" => "bearer #{@token}" }
  end
end
