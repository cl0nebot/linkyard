class NewsController < ApplicationController
  before_action :only_administrator

  def index
    period = params[:period] ? params[:period].to_sym : :week
    @news = FetchRedditNews.new(period: period).call
  end
end
