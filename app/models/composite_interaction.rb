class CompositeInteraction < Interaction
  store_accessor :configuration, :interaction_ids
  validates :interaction_ids, presence: true
  validate :interaction_ids_are_on_user

  def self.atomic?
    false
  end

  private
  def interaction_ids_are_on_user
    errors.add(:interaction_ids, "should be an array") and return unless interaction_ids.respond_to?(:each)

    interaction_ids.each do |id|
      errors.add(:interaction_ids, "should have only user's interactions") unless user.interactions.exists?(id)
    end
  end
end
