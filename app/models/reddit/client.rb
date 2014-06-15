class Reddit::Client 
  def initialize(token, refresh_token, on_token_update = nil)
    @connection = Connection.new(token, refresh_token, on_token_update)
  end

  def submit(url, title, subreddit, save: false, resubmit: false, send_replies: false)
    parameters = { 
      :api_type => "json",
      :extension => "json",
      :kind => "link",
      :sr => subreddit,
      :url => url,
      :title => title
    }
    
    response(@connection.post("submit", parameters), [Submission, Captcha])
  end

  def needs_captcha?
    @connection.get("needs_captcha.json") == 'true'
  end

  def vote
  end

  def me
    response(@connection.get("v1/me"), [Identity])
  end

  private
  def response(response, parsers)
    json = JSON.parse(response)
    parsers.each do |parser| 
      response = parser.parse_from(json) 
      byebug
      return response if response.present?
    end
    Unknown.new(json)
  end
end
