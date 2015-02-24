require 'rails_helper'

describe ScheduleLinkAtBestTime do
  let(:interaction) { DummyInteraction.create!(user_id: 1) }
  let(:link) { Link.create!(title: 'Test', url: 'http://google.com', user_id: 1) }
  let(:link_interaction) do
    LinkInteraction.create! do |link_interaction|
      link_interaction.interaction = interaction
      link_interaction.link = link
    end
  end

  before { Timecop.freeze(Time.now) }

  it "schedules the link interaction for the best time" do
    time_to_post = Time.now + 1.hour
    BestTime.create!(interaction: 'DummyInteraction', time: time_to_post)

    expect(InteractionWorker).to receive(:perform_at) do |time_to_perform, id|
      expect(time_to_perform.to_i).to eq time_to_post.to_i
      expect(id).to eq link_interaction.id
    end

    ScheduleLinkAtBestTime.schedule(link_interaction)
  end
end
