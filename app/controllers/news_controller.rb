class NewsController < ApplicationController
  before_action :only_administrator

  def index
    period = params[:period] ? params[:period].to_sym : :week
    @programming_news = FetchRedditNews.new("programming", period).call
    @webdev_news = FetchRedditNews.new("webdev", period).call
    @csharp_news = FetchRedditNews.new("csharp", period).call
    @ruby_news = FetchRedditNews.new("ruby", period).call
    @elixir_news = FetchRedditNews.new("elixir", period).call
    @react_news = FetchRedditNews.new("reactjs", period).call
    @react_news = FetchRedditNews.new("reactnative", period).call
  end
end
