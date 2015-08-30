class LinkInteraction < ActiveRecord::Base
  belongs_to :interaction
  belongs_to :link

  def self.top_scheduled_pending
    ids = joins(:interaction).select("MIN(link_interactions.id) as id").where({ status: "pending", interactions: { type: "ScheduledInteraction" }}).group("interactions.user_id").map(&:id)
    where(id: ids).includes(:interaction).includes(:link)
  end

  def self.scheduled_pending_for(user)
    joins(:interaction).where(status: "pending", interactions: { type: "ScheduledInteraction", user_id: user.id })
  end

  def act
    interaction.act(self)
  end

  def update_and_notify!(status, description)
    update!(:status => status, :status_description => description)
  end

  def perform_or_schedule!
    if interaction.try!(:post_at_best_time?)
      ScheduleLinkAtBestTime.schedule(self)
    elsif interaction.kind_of?(ScheduledInteraction)
      # ignore as it is picked up by job
    else
      InteractionWorker.perform_async(id)
    end
  end

  def to_s
    LinkInteractionPresenter.new(self).to_s
  end
end
