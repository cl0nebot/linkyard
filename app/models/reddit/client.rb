class Reddit::Client 
  def initialize(token, refresh_token)
    @connection = Connection.new(token, refresh_token)
  end

  def add_token_update_listener(&block)
    @connection.add_token_update_listener(&block)
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
    
    response(@connection.post("submit", parameters), [Submission])
  end

  def needs_captcha?
    @connection.get("needs_captcha.json") == 'true'
  end

  def vote(id, direction)
  end

  def me
    response(@connection.get("v1/me"), [Identity])
  end
  
  def info(url, subreddit)
    response(@connection.get("info.json", { :url => url }, "r/#{subreddit}/"), [Listing])
  end

  private
  def response(json, available_responses)
    data = JSON.parse(json)
    [Error, available_responses, Unknown].flatten.detect { |i| i.parseable?(data) }.new(data)
  end
end
