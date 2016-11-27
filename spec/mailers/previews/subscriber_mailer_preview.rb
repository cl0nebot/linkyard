# Preview all emails at http://localhost:3000/rails/mailers/subscriber_mailer
class SubscriberMailerPreview < ActionMailer::Preview
  def confirm
    return SubscriberMailer.confirm(Subscriber.last)
  end
end
