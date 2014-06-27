module Reddit
  class Connection
    def initialize(token, refresh_token)
      @token = token
      @refresh_token = refresh_token
      @token_update_listeners = []
    end

    def get(method, parameters = {}, subreddit = nil)
      api_request(method, parameters, :get_request, subreddit)
    end

    def post(method, parameters = {}, subreddit = nil)
      api_request(method, parameters, :post_request, subreddit)
    end

    def add_token_update_listener(&block)
      @token_update_listeners << block
    end

    private 
    def api_request(method, parameters, request, subreddit)
      request = self.send(request, api_path(method, subreddit), parameters)
      response = execute_request(request)
      response = execute_request(request) if unauthorized?(response) && refresh_access_token
      response
    end

    def refresh_access_token
      request = post_request(authentication_uri, { "grant_type" => "refresh_token", "refresh_token" => @refresh_token })
      request.basic_auth(api_key, api_secret)
      response = execute_request(request, should_authorize: false)
      success?(response).tap { |result| update_token(response) }
    end

    # Q - should I use bang?
    def update_token(response)
      @token = JSON.parse(response.body)["access_token"]
      @token_update_listeners.each { |listener| listener.call(@token) }
    rescue JSON::ParseError => e
      fail ResponseError, "Failed to parse JSON when updating access token"
    end

    def get_request(path, parameters)   
      Net::HTTP::Get.new(URI([path, URI.encode_www_form(parameters)].join("?")))
    end

    def post_request(path, parameters)
      Net::HTTP::Post.new(URI(path)).tap { |request| request.set_form_data(parameters) }
    end

    def execute_request(request, should_authorize: true)
      request['Authorization'] = "bearer #{@token}" if should_authorize
      Net::HTTP.start(request.uri.hostname, request.uri.port, use_ssl: request.uri.scheme == 'https') { |http| http.request(request) }
    end

    def unauthorized?(response)
      response.code == "401"
    end

    def success?(response)
      response.code == "200"
    end

    def api_key
      @api_key ||= Rails.application.secrets.reddit_api_key
    end

    def api_secret
      @api_secret ||= Rails.application.secrets.reddit_api_secret
    end

    def api_path(method, subreddit)
      "https://oauth.reddit.com/#{subreddit}api/#{method}"
    end

    def authentication_uri
      @authentication_uri ||= URI("https://ssl.reddit.com/api/v1/access_token")
    end
  end
end
