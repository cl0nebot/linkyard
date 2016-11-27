class DigestMailer < ActionMailer::Base
  include ApplicationHelper
  add_template_helper(ApplicationHelper)

  def weekly(digest, subscriber)
    @digest = digest
    @subscriber = subscriber
    headers['X-MC-PreserveRecipients'] = false
    mail to: @subscriber.email,
      from: "jakub@#{@digest.type}digest.net",
      reply_to: "jakub.chodounsky@gmail.com",
      subject: "#{digest_name(@digest.type)} Digest ##{@digest.issue}",
      delivery_method_options: { domain: @digest.domain }
  end
end
