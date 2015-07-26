class ScheduleLinkAtBestTime
  def self.schedule(link_interaction)
    new(link_interaction).call
  end

  def initialize(link_interaction)
    @link_interaction = link_interaction
  end

  def call
    InteractionWorker.perform_at(
      best_time_to_post,
      @link_interaction.id,
    )

    @link_interaction.update!(:scheduled_time => best_time_to_post)
  end

  private

  def best_time_to_post
    @best_time_to_post ||= @link_interaction.interaction.best_time_to_post
  end
end
