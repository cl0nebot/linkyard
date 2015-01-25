require 'open-uri'

class ArticleContentFetcher
  def initialize(url)
    @url = normalize(url)
  end

  def fetch
    source = open(@url).read
    doc = Readability::Document.new(source)
    { url: @url, title: doc.title, content: doc.content }
  rescue SocketError, OpenURI::HTTPError
    { url: @url, title: "", content: "" }
  end

  private
  def normalize(url)
    url.starts_with?("http") ? url : "http://" + url
  end
end
