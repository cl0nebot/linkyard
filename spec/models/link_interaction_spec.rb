require 'rails_helper'

describe LinkInteraction do
  let(:interaction) { DummyInteraction.create!(user_id: 1) }
  let(:link) { Link.create!(title: 'Test', url: 'http://google.com', user_id: 1) }
  let(:link_interaction) do
    LinkInteraction.create! do |link_interaction|
      link_interaction.interaction = interaction
      link_interaction.link = link
    end
  end

  describe "#act" do

    it "should act on interaction" do
      expect(interaction).to receive(:act).with(link_interaction)
      link_interaction.act
    end
  end

  describe "#perform_or_schedule!" do
    before { allow(InteractionWorker).to receive(:perform_async) } 

    context "not to be posted at the best time" do
      it "passes the LinkInteraction to InteractionWorker" do
        expect(InteractionWorker).to receive(:perform_async).with(link_interaction.id)
        link_interaction.perform_or_schedule!
      end
    end

    context "to be posted at the best time" do
      before { interaction.update(:post_at_best_time => true) }

      it "schedules the LinkInteraction to be posted at the best time" do
        expect(ScheduleLinkAtBestTime).to receive(:schedule).with(link_interaction)
        link_interaction.perform_or_schedule!
      end
    end
  end
end
