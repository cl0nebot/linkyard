module Reddit
  class Client 
    def initialize(token, refresh_token)
      @connection = Connection.new(token, refresh_token)
    end

    def add_token_update_listener(&block)
      @connection.add_token_update_listener(&block)
    end

    # Q - should I have ! in every public method?
    def submit(url, title, subreddit, save: false, resubmit: false, send_replies: false)
      parameters = { 
        :api_type => "json",
        :extension => "json",
        :kind => "link",
        :sr => subreddit,
        :url => url,
        :title => title,
        :save => save,
        :resubmit => resubmit,
        :send_replies => send_replies
      }
      
      response_from_json!(@connection.post("submit", parameters), Submission)
    end

    def needs_captcha?
      response_form!(@connection.get("needs_captcha.json")) == "true"
    end

    def vote(id, direction)
      response_from_json!(@connection.post("vote", {:id => id, :dir => direction }), Empty)
    end

    def me
      response_from_json!(@connection.get("v1/me"), Identity)
    end
    
    def info(url, subreddit)
      response_form_json!(@connection.get("info.json", { :url => url }, "r/#{subreddit}/"), Listing)
    end

    private
    def parse_json!(response)
      JSON.parse(response)
    rescue JSON::ParseError => e
      fail ResponseError, "Failed to parse JSON"
    end

    def response_from!(response)
      fail_if_not_success!(response)
      response.body
    end

    def response_from_json!(response, response_class)
      fail_if_not_success!(response)
      data = parse_json!(response.body)
      fail ResponseError, "The class #{response_class} is not parseable from #{data}" unless response_class.parseable?(data)
      response_class.new(data)
    end

    def fail_if_not_success!(response)
      fail ResponseError, "Request was unsuccessful with code #{response.code}" unless response.code == "200"      
    end
  end
end
