class SubscriberMailer < ActionMailer::Base
  include ApplicationHelper
  add_template_helper(ApplicationHelper)

  def confirm(subscriber)
    @subscriber = subscriber
    @domain = Weekly::Digest.domain_from(@subscriber.digest)
    mail to: @subscriber.email,
      from: "jakub@#{@subscriber.digest}digest.net",
      reply_to: "jakub.chodounsky@gmail.com",
      subject: "Email confirmation for #{digest_name(@subscriber.digest)} Digest",
      delivery_method_options: { domain: @domain }
  end
end
