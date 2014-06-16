class Reddit::Connection

  AUTHENTICATION_URI = URI("https://ssl.reddit.com/api/v1/access_token")
  API_PATH = "https://oauth.reddit.com/api/"

  def initialize(token, refresh_token)
    @token = token
    @refresh_token = refresh_token
    @token_update_listeners = []
  end

  def get(method, parameters = {})
    api_request(method, parameters, :get_request)
  end

  def post(method, parameters = {})
    api_request(method, parameters, :post_request)
  end

  def add_token_update_listener(&block)
    @token_update_listeners << block
  end

  private 
  def api_request(method, parameters, request)
    request = self.send(request, URI(API_PATH + method), parameters)
     
    response = execute_request(request)
    response = execute_request(request) if unauthorized?(response) && refresh_access_token

    response.body
  end

  def refresh_access_token
    request = post_request(AUTHENTICATION_URI, { "grant_type" => "refresh_token", "refresh_token" => @refresh_token })
    request.basic_auth(api_key, api_secret)
    response = execute_request(request, should_authorize: false)
     
    success?(response).tap do |result|
      if result
        @token = JSON.parse(response.body)["access_token"] # handle if not JSON, but true instead
        @token_update_listeners.each { |listener| listener.call(@token) }
      end
    end
  end

  def get_request(uri, parameters)   
    Net::HTTP::Get.new(uri)
  end

  def post_request(uri, parameters)
    Net::HTTP::Post.new(uri).tap { |request| request.set_form_data(parameters) }
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
end
