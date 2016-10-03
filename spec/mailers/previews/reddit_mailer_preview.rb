# Preview all emails at http://localhost:3000/rails/mailers/reddit_mailer
class RedditMailerPreview < ActionMailer::Preview
  def daily
    return RedditMailer.daily
  end

  def weekly
    return RedditMailer.weekly
  end
end
