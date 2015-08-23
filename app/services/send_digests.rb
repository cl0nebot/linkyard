class SendDigests
  def self.run
    new.call
  end

  def call(types=Weekly::Digest::TYPES)
    types.each do |type|
      digest = Weekly::Digest.current_digest(type)
      Subscriber.active.where(digest: type).each do |subscriber|
        DigestMailer.weekly(digest, subscriber).deliver
      end
    end
  end
end
