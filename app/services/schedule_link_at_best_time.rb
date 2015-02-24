class ScheduleLinkAtBestTime
  def self.schedule(link_interaction)
    new(link_interaction).call
  end

  def initialize(link_interaction)
    @link_interaction = link_interaction
  end

  def call
    InteractionWorker.perform_at(
      @link_interaction.interaction.best_time_to_post,
      @link_interaction.id,
    )
  end
end
