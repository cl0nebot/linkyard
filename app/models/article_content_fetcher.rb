require 'open-uri'

class ArticleContentFetcher
  def initialize(url, remove_utm_params: true)
    @remove_utm_params = remove_utm_params
    @url = normalize(url)
  end

  def fetch
    response = open("https://mercury.postlight.com/parser?url=#{@url}",
                    "Content-Type" => "application/json",
                    "x-api-key" => Rails.application.secrets.mercury_key).read
    json = JSON.parse(response)
    { url: @url, title: json["title"], content: json["content"] }
  rescue SocketError, OpenURI::HTTPError, JSON::ParserError
    { url: @url, title: "", content: "" }
  end

  private
  def normalize(url)
    uri = URI(url.starts_with?("http") ? url : "http://" + url)
    if @remove_utm_params && uri.query.present?
      params = CGI.parse(uri.query)
      params.delete("utm_source")
      params.delete("utm_medium")
      params.delete("utm_content")
      params.delete("utm_campaign")
      uri.query = params.blank? ? nil : URI.encode_www_form(params)
    end
    uri.to_s
  end
end
