class ScheduledInteraction < Interaction
  store_accessor :configuration, :scheduled_times
  validates :scheduled_times, presence: true

  def self.humanized_name
    "Scheduled Twitter"
  end
end
