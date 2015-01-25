require 'spec_helper'

describe LinkInteraction do
  describe "#act" do
    let(:interaction) { Interaction.new}
    let(:link) { Link.new}
    let(:link_interaction) do
      LinkInteraction.new.tap do |link_interaction|
        link_interaction.interaction = interaction
        link_interaction.link = link
      end
    end

    it "should act on interaction" do
      expect(interaction).to receive(:act).with(link_interaction)
      link_interaction.act
    end
  end
end
