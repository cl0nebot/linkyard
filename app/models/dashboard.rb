class Dashboard
  def self.subscriber_stats
    this_week = Time.zone.now.beginning_of_week..Time.zone.now.end_of_week
    last_week = (this_week.first - 7.days)..(this_week.last - 7.days)
    all_subscribers = Subscriber.active.group(:digest).count.map { |k, v| [k, [v]] }.to_h
    new_subscribers_this_week = Subscriber.active.where(created_at: this_week).group(:digest).count
    new_subscribers_last_week = Subscriber.active.where(created_at: last_week).group(:digest).count

    [all_subscribers, new_subscribers_this_week, new_subscribers_last_week].reduce do |a, b|
      a.merge(b) { |key, v1, v2| [v1, v2].flatten }
    end
  end

  def self.future_digests
    Weekly::Digest::TYPES.map { |type| Weekly::Digest.new(type, issue: Weekly::Digest.issue_from(type, Time.zone.now) + 1) }
  end

  def self.pending_interactions
    LinkInteraction.joins(:interaction).joins(:link)
      .select("count(*) as count, links.digest")
      .where({ status: "pending", interactions: { type: "ScheduledInteraction", user_id: 7 }})
      .group("links.digest")
      .map { |i| [i.digest, i.count] }
  end

  def self.unsubscribed
    Subscriber.where.not(unsubscribed_at: nil).group(:digest).count
  end

  def self.sponsor_stats
    sponsor_tag_id = 268
    Weekly::Digest::TYPES.map { |digest| Tag.find(sponsor_tag_id).links.where(digest: digest).order(created_at: :desc).first(10) }
  end
end
