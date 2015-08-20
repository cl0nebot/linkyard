class SendDigests
  def self.run
    new.call
  end

  def call
    DigestMailer.delay.weekly(Weekly::Digest::PROGRAMMING)
  end
end
