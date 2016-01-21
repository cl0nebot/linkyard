class Analytics
  def initialize(date_range)
    @date_range = date_range
  end

  def tags
    Weekly::Digest::TYPES.map { |digest| formatted_tags(digest, @date_range) }
  end

  def links
    Weekly::Digest::TYPES.map { |digest| formatted_links(digest, @date_range) }
  end

  def link_count
    Weekly::Digest::TYPES.map { |digest| Link.where(digest:digest, created_at: @date_range).count }
  end

  def subscribers
    Weekly::Digest::TYPES.map { |digest| Subscriber.where(digest: digest).where("created_at < ? AND (unsubscribed_at IS NULL OR unsubscribed_at > ?)", @date_range.end.end_of_day, @date_range.end.end_of_day).count }
  end

  private
  def top(values, size: 10)
    values
    .inject(Hash.new(0)) { |h, e| h[e] += 1; h }
    .sort_by { |k, v| -v }[0..10].to_h
  end

  def md_format(hash)
  end

  def md_format(hash)
    hash.keys.reduce("") { |acc, key| acc << "* #{key} (#{hash[key]}x)\n" }
  end

  def formatted_tags(digest, date_range)
    tags = Link.includes(:tags)
    .where(digest: digest, created_at: date_range)
    .flat_map { |l| l.tags.map(&:name) }
    md_format(top(tags))
  end

  def formatted_links(digest, date_range)
    uris = Link.where(digest: digest, created_at: date_range).map { |l| URI.parse(l.url.strip) }
    top_hosts = top(uris.map { |u| u.host })
    top_hosts.keys.reduce("") { |acc, key| acc << "* [#{key}](#{key}) (#{top_hosts[key]}x)\n" }
  end
end
