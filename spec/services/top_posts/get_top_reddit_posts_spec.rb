require 'spec_helper'

describe TopPosts::GetTopRedditPosts, :vcr do
  let(:posts) { TopPosts::GetTopRedditPosts.new.call }
  let(:post) { posts.first }

  it 'gets the top 1000 posts from reddit in the last month' do
    expect(posts.size).to be >= TopPosts::GetTopRedditPosts::POST_COUNT
  end

  describe 'a post' do
    subject { post }

    it { should respond_to(:created_at, :score) }
  end
end
