class TwitterInteraction < Interaction
  validate :must_be_connected_to_twitter

  def act(link_interaction)
    link = link_interaction.link
    text = "#{link.title} #{link.url} #{ tags_to_hashtag_list(link.tags) }"
    Tweet.new(text, user, link.digest).call
    link_interaction.update_and_notify!(:success, "submitted")
  rescue Twitter::Error => e
    link_interaction.update_and_notify!(:error, e.message)
  end

  protected
  def must_be_connected_to_twitter
    errors.add(:base, "Twitter account has to be assigned to the user before adding interaction.") unless user.has_twitter_access?
  end

  def tags_to_hashtag_list(tags)
    tags.map { |t| "#" + t.name }.join(" ")
  end
end
