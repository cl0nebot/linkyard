class CompositeInteraction < Interaction
  store_accessor :configuration, :interaction_ids
  validates :interaction_ids, presence: true
  validate :interaction_ids_are_on_user

  def self.atomic?
    false
  end

  def act(link_interaction)
    composed_interactions.each do |interaction|
      interaction.act(link_interaction)
      break unless link_interaction.status == :success
    end
  end


  def composed_interactions
    interaction_ids.nil? ? [] : interaction_ids.map { |id| user.interactions.find(id) }
  end

  def self.prepare(attributes)
    attributes[:interaction_ids] = (attributes[:interaction_ids] || {}).select { |_, checked| checked == "1" }.map { |id, _| id }
    super
  end

  private
  def interaction_ids_are_on_user
    errors.add(:interaction_ids, "should be an array") and return unless interaction_ids.respond_to?(:each)
    interaction_ids.each do |id|
      errors.add(:interaction_ids, "should have only user's interactions") unless user.interactions.exists?(id)
    end
  end
end
