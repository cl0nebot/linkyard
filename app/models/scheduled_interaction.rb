class ScheduledInteraction < CompositeInteraction
  store_accessor :configuration, :scheduled_times
  validates :scheduled_times, presence: true
  validate :scheduled_times_are_valid_times, :interaction_ids_are_on_user

  SCHEDULE_INTERVAL = 30.minutes

  def ready?(now)
    scheduled_times.detect do |time|
      offset = now.to_time - DateTime.parse(time).to_time
      offset < SCHEDULE_INTERVAL && offset >= 0
    end.present?
  end

  def self.prepare(attributes)
    attributes[:scheduled_times] = (attributes[:scheduled_times] || {}).map { |_, time| time }
    super
  end

  private
  def scheduled_times_are_valid_times
    errors.add(:scheduled_times, "should be an array") and return unless scheduled_times.respond_to?(:each)

    scheduled_times.each do |time|
      errors.add(:scheduled_times, "should be in HH:MM format") unless time =~ /([0-1][0-9]|2[0-3]):[0|3]0/
    end
  end
end
