class DigestMailer < ActionMailer::Base
  def weekly
    @digest = Weekly::Digest.current_digest
    headers['X-MC-PreserveRecipients'] = false
    Subscriber.active.where(email: "jakub.chodounsky@gmail.com").where(digest: "programming").each do |subscriber|
      @subscriber = subscriber
      mail to: @subscriber.email,
           from: "jakub@programmingdigest.net",
           reply_to: "jakub.chodounsky@gmail.com",
           subject: "Weekly Programming Digest ##{@digest.issue}",
           delivery_method_options: { domain: "programmingdigest.net" }
    end
  end
end
