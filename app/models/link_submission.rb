class LinkSubmission
  include ActiveModel::Model

  attr_accessor :user, :url, :title, :tags, :description, :content, :link_interactions, :link

  def self.new_from_user(user)
    new(user: user, link_interactions: {})
  end

  def save(options)
    self.url = options[:url]
    self.title = options[:title]
    self.tags = options[:tags]
    self.description = options[:description]
    self.content = options[:content]

    self.link_interactions = build_link_interactions_from(options[:link_interaction_ids])
    self.link = build_link
    link.link_interactions = self.link_interactions
    link.link_tags = build_link_tags

    if link.save_and_publish
      true
    else
      link.errors.each { |attribute, message| errors.add(attribute, message) }
      false
    end
  end

  def interactions
    user.interactions
  end

  def available_tags
    user.tags.map { |tag| tag.name }
  end

  protected
  def build_link
    user.links.build(title: title, url: url, description: description, content: content)
  end

  def build_link_interactions_from(ids)
    self.link_interactions = ids.map { |id| build_link_interaction_from(id) }
  end

  def build_link_interaction_from(id)
    LinkInteraction.new(interaction: user.interactions.find(id), status: :pending)
  end

  def build_link_tags
    tags.split(',').map.with_index do |tag, index|
      tag = user.tags.where(name: tag).first_or_initialize
      LinkTag.new(tag: tag, default: index == 0)
    end
  end
end
