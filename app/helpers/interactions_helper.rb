module InteractionsHelper
  def available_interaction_options
    Interaction::AVAILABLE_INTERACTIONS.map { |interaction| [Interaction.humanize_type(interaction), interaction] }
  end
end
