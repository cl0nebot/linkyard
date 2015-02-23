class ScheduledInteractionWorker
  include Sidekiq::Worker

  def perform
    now = DateTime.now.utc
    pending_interactions = LinkInteraction.top_scheduled_pending.select { |li| li.interaction.ready?(now) }
    pending_interactions.each(&:act)
  end
end
