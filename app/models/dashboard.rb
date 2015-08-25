class Dashboard
  def self.subscriber_stats
    Subscriber.active.group(:digest).count
  end

  def self.future_digests
    Weekly::Digest::TYPES.map { |type| Weekly::Digest.new(type, issue: Weekly::Digest.issue_from(type, Time.zone.now) + 1) }
  end
end
