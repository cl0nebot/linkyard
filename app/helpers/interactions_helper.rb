module InteractionsHelper
  def available_interaction_options
    Interaction.available_interactions.map { |interaction| [interaction.humanized_name, interaction] }
  end
end
