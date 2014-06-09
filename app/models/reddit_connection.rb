class RedditConnection

  AUTHENTICATION_URI = "https://ssl.reddit.com/api/v1/"
  API_URI = "https://oauth.reddit.com/api/v1/"

  def initialize(token, refresh_token, asd)
    @token = token
    @refresh_token = refresh_token
  end

  def get(method, parameters = {})
    send_request(method, parameters, :get_request)
  end

  def post(method, parameters = {})
    send_request(method, parameters, :post_request)
  end

  private 
  def send_request(method, parameters, request)
    response = self.send(request, method, parameters)
    response = self.send(request, method, parameters) if unauthorized?(response) && refresh_access_token
       
    JSON.parse(response.body)
  end

  def refresh_access_token
    parameters = { "grant_type" => "refresh_token", "refresh_token" => @refresh_token }
    response = post_request("access_token", parameters, AUTHENTICATION_URI, true)
    
    success?(response) && update_token_from(response)
  end

  def get_request(method, parameters)   
    uri = URI(API_URI + method)
    req = Net::HTTP::Get.new(uri)
    req['Authorization'] = "bearer #{@token}"
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
  end

  def post_request(method, parameters, api = API_URI, should_authenticate = false)
    uri = URI(api + method)
    req = Net::HTTP::Post.new(uri)
    req.set_form_data(parameters)
    req['Authorization'] = "bearer #{@token}" unless should_authenticate
    req.basic_auth(api_key, api_secret) if should_authenticate
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') { |http| http.request(req) }
  end

  def unauthorized?(response)
    response.code == "401"
  end

  def success?(response)
    response.code == "200"
  end

  def update_token_from(response)
    @token = JSON.parse(response.body)['access_token']
    on_token_update
  end

  # override this method if you want to trigger an action on update token
  def on_token_update
    true
  end

  def api_key
    @api_key ||= Rails.application.secrets.redit_api_key
  end

  def api_secret
    @api_secret ||= Rails.application.secrets.redit_api_secret
  end
end
