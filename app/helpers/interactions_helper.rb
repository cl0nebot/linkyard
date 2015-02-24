module InteractionsHelper
  def available_interaction_options
    Interaction.available_interactions.map { |interaction| [interaction.humanized_name, interaction] }
  end

  def available_times
    (0..23).map { |h| '%02d' % h }.map do |hh|
      ["00", "35"].map do |mm|
        ["#{hh}:#{mm}", "#{hh}:#{mm}"]
      end
    end.flatten(1)
  end
end
