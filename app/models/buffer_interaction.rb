class BufferInteraction < Interaction
  validate :must_be_connected_to_buffer

  def act(link_interaction)
    client = client_for(link_interaction.link.digest)
    profile_ids = client.profiles.map(&:id)
    text = "#{link_interaction.link.title} #{link_interaction.link.url} #{ tags_to_hashtag_list(link_interaction.link.tags) }"
    client.create_update(body: { text: text, profile_ids: profile_ids })
    link_interaction.update_and_notify!(:success, "submitted")
  rescue => e
    link_interaction.update_and_notify!(:error, e.message)
  end

  protected
  def client_for(digest)
    @client ||= Buffer::Client.new(user.buffer_authorization(digest).token)
  end

  def must_be_connected_to_buffer
    errors.add(:base, "Buffer account has to be assigned to the user before adding interaction.") unless user.has_buffer_access?
  end

  def tags_to_hashtag_list(tags)
    tags.map { |t| "#" + t.name }.join(" ")
  end
end
