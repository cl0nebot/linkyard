require 'spec_helper'

describe CalculateBestTimeToPost, :vcr do
  let(:posts) { TopPosts::GetTopRedditPosts.new.call }
  let(:service) { CalculateBestTimeToPost.new(posts) }

  it 'does a thing' do
    expect(service.call.strftime(CalculateBestTimeToPost::TIME_FORMAT)).to eq 'Wednesday 7am'
  end
end
