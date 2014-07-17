class LinkSubmission
  include ActiveModel::Model

  attr_accessor :user
  attr_accessor :link

  def self.new_from(user, params)
    link = user.links.build(params[:link].permit(:url, :title))
    link.link_interactions = create_link_interactions_from(user, params[:link][:link_interactions] || {})
    new(link: link, user: user)
  end

  def save
    @link.save_and_publish
  end

  def interactions
    @interactions ||= user.interactions
  end

  def available_tags
    @available_tags ||= user.tags
  end

  def link
    @link ||= user.links.build
  end

  protected
  def self.create_link_interactions_from(user, link_interaction_params)
    link_interaction_params.select { |_, checked| checked == "1"}.map do |interaction_id, _|
      LinkInteraction.new(interaction: user.interactions.find(interaction_id), status: :pending)
    end
  end
end
