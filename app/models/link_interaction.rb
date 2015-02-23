class LinkInteraction < ActiveRecord::Base
  belongs_to :interaction
  belongs_to :link

  def self.top_scheduled_pending
    ids = joins(:interaction).select("MIN(link_interactions.id) as id").where({ status: "pending", interactions: { type: "ScheduledInteraction" }}).group("interactions.user_id").map(&:id)
    where(id: ids).includes(:interaction).includes(:link)
  end

  def act
    interaction.act(self)
  end

  def update_and_notify!(status, description)
    update!(:status => status, :status_description => description)
  end
end
