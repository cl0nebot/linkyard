class Statistics

  def self.avg_ctr(type, issues, &block)
    issues.map { |i| Statistics.new(Weekly::Digest.new(type, issue: i)) }.reduce(0) { |sum, s| s.avg_ctr + sum }.to_f / issues.size
  end

  def initialize(digest)
    @digest = digest
  end

  def number_of_subscribers
    @number_of_subscribers ||= Subscriber.where(digest: @digest.type)
      .where("unsubscribed_at is null or unsubscribed_at > ?", @digest.to)
      .where("created_at < ?", @digest.to)
      .count
  end

  def avg_ctr
    links_without_sponsors.reduce(0) { |sum, link| sum + ctr(link) }.to_f / links_without_sponsors.size
  end

  def max_ctr
    links_without_sponsors.map { |link| ctr(link) }.max
  end

  def min_ctr
    links_without_sponsors.map { |link| ctr(link) }.min
  end

  def to_s
    "(#{@digest.type} ##{@digest.issue}) ctr: [#{avg_ctr.round(2)} | #{min_ctr.round(2)} | #{max_ctr.round(2)}]"
  end

  def links_with_ctr
    links_without_sponsors
      .sort { |a, b| ctr(a) <=> ctr(b) }
      .map { |l| { title: l.title, ctr: ctr(l), url: l.url }}
  end

  private
  def ctr(link)
    (link.clicks.to_f / number_of_subscribers) * 100
  end

  def links_without_sponsors
    @links_without_sponsors ||= @digest.links
      .joins(:tags)
      .where.not(tags: { id: job_tag_ids + sponsor_tag_ids })
      .distinct
  end

  def sponsor_links
    @sponsor_links ||= @digest.links
      .joins(:tags)
      .where(tags: { id: job_tag_ids + sponsor_tag_ids })
      .distinct
  end

  def job_tag_ids
    [912, 1007]
  end

  def sponsor_tag_ids
    [268]
  end
end
