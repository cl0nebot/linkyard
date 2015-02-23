class ScheduledInteraction < CompositeInteraction
  store_accessor :configuration, :scheduled_times
  validates :scheduled_times, presence: true
  validate :scheduled_times_are_valid_times, :interaction_ids_are_on_user

  SCHEDULE_INTERVAL = 30.minutes

  def act(link_interaction)
    interactions.each do |interaction|
      interaction.act(link_interaction)
      break unless link_interaction.status == :success
    end
  end

  def ready?(now)
    scheduled_times.detect do |time|
      offset = now.to_time - DateTime.parse(time).to_time
      offset < 30.minutes && offset >= 0
    end.present?
  end

  private
  def interactions
    interaction_ids.map { |id| user.interaction.find(id) }
  end

  def scheduled_times_are_valid_times
    errors.add(:scheduled_times, "should be an array") and return unless scheduled_times.respond_to?(:each)

    scheduled_times.each do |time|
      errors.add(:scheduled_times, "should be in HH:MM format") unless time =~ /([0-1][0-9]|2[0-3]):[0|3]0/
    end
  end
end
