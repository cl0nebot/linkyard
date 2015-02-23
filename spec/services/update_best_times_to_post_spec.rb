require 'spec_helper'

describe UpdateBestTimesToPost, :vcr do

  it 'creates a best time for each interaction' do
    expect { UpdateBestTimesToPost.run }
      .to change { BestTime.count }.by UpdateBestTimesToPost::INTERACTIONS_TO_CHECK.count
  end

  it 'saves the interaction properly' do
    time_to_save = Time.now

    allow(CalculateBestTimeToPost).to receive(:new)
      .and_return(double(:call => time_to_save))

    stub_const("UpdateBestTimesToPost::INTERACTIONS_TO_CHECK", {
      :RedditInteraction => double(:new => -> { [] })
    })

    UpdateBestTimesToPost.run

    saved_time = BestTime.last
    expect(saved_time.time.strftime('%A %-l%p')).to eq time_to_save.strftime('%A %-l%p')
    expect(saved_time.interaction).to eq 'RedditInteraction'
  end
end
