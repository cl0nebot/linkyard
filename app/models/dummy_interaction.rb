class DummyInteraction < Interaction
  def act(link_interaction)
    raise "WE SCHEDULED AN INTERACTION"
  end
end
