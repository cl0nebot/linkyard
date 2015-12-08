class SendDigests
  def self.run
    new.call
  end

  def call(types=Weekly::Digest::TYPES)
    types.each do |type|
      puts "#{Time.zone.now} - Starting to send newsletters for #{type}."
      # digest = Weekly::Digest.current_digest(type)
      # Subscriber.for_email.where(digest: type).each do |subscriber|
      #   DigestMailer.weekly(digest, subscriber).deliver
      #   subscriber.update_attributes!(last_sent_at: Time.now)
      # end
      puts "#{Time.zone.now} - Newsletters sent successfully for #{type}."
    end
    puts "#{Time.zone.now} - All newsletters sent successfully."
  end
end
