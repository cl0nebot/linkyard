class ArticleContentFetcher
  def initialize(url)
    @url = url
  end

  def fetch
    api_path = URI.parse(Rails.application.config.article_content_api_path + @url)
    request = Net::HTTP::Get.new(api_path.to_s)
    begin
      response = Net::HTTP.start(api_path.host, api_path.port) { |http| http.request(request) }
      { url: @url }.merge(JSON.parse(response.body))
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, Errno::ECONNREFUSED, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError
      { url: @url, title: "", content: "" }
    end
  end
end
