class InteractionWorker
  include Sidekiq::Worker

  def perform(link_interaction_id, type)
    # do something
  end
end
