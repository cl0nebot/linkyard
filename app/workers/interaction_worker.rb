class InteractionWorker
  include Sidekiq::Worker

  def perform(link_interaction_id)
    LinkInteraction.find(link_interaction_id).act
  end
end
