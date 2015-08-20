class DigestMailer < ActionMailer::Base
  def weekly(type)
    @digest = Weekly::Digest.current_digest(type)
    headers['X-MC-PreserveRecipients'] = false
    Subscriber.active.where(digest: type).each do |subscriber|
      @subscriber = subscriber
      mail to: @subscriber.email,
           from: "jakub@#{@digest.type}digest.net",
           reply_to: "jakub.chodounsky@gmail.com",
           subject: "Weekly #{@digest.type.capitalize} Digest ##{@digest.issue}",
           delivery_method_options: { domain: @digest.domain }
    end
  end
end
