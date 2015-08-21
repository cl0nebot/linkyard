class SendDigests
  def self.run
    new.call
  end

  def call
    Weekly::Digest::TYPES.each do |type|
      DigestMailer.delay.weekly(type)
    end
  end
end
