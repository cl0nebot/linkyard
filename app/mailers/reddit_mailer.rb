class RedditMailer < ActionMailer::Base
  include ApplicationHelper

  def daily
    @news = FetchRedditNews.new(period: :day).call
    mail to: "jakub.chodounsky@gmail.com",
         from: "jakub@programmingdigest.net",
         subject: "Reddit Daily #{Date.today}",
         template_name: "weekly"
  end

  def weekly
    @news = FetchRedditNews.new(period: :week).call
    mail to: "jakub.chodounsky@gmail.com",
         from: "jakub@programmingdigest.net",
         subject: "Reddit Weekly #{Date.today}"

  end
end
