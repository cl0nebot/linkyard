class SendDigests
  def self.run
    new.call
  end

  def call(types=Weekly::Digest::TYPES)
    types.each do |type|
      digest = Weekly::Digest.current_digest(type)
      Subscriber.for_email.where(digest: type).each do |subscriber|
        DigestMailer.weekly(digest, subscriber).deliver
        subscriber.update_attributes!(last_sent_at: Time.now)
      end
    end
  end
end
