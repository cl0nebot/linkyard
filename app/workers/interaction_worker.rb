class InteractionWorker
  include Sidekiq::Worker

  def perform(link_interaction_id)
    link_interaction = LinkInteraction.find(link_interaction_id)
    link_interaction.interaction.act(link_interaction.link)
  end
end
