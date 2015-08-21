class SendDigests
  def self.run
    new.call
  end

  def call
    Weekly::Digest::TYPES.each do |type|
      DigestMailer.delay.weekly(type) if Weekly::Digest.issue_from(type, Time.zone.now) > 0
    end
  end
end
