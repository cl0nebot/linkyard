require 'spec_helper'

describe CalculateBestTimeToPost do
  def load_posts_from_json
    TopPosts::GetTopRedditPosts.new.call
  end

  let(:posts) { load_posts_from_json }
  let(:service) { CalculateBestTimeToPost.new(posts) }

  it 'does a thing' do
    expect(service.call.strftime(CalculateBestTimeToPost::TIME_FORMAT)).to eq 'Friday 5am'
  end
end
