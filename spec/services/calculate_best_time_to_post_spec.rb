require 'spec_helper'

describe CalculateBestTimeToPost do
  class RedditPost
    attr_reader :score, :created_at
    def initialize(json)
      @score = json['score'].to_i
      @created_at = Time.at(json['created_at'])
    end
  end

  def load_posts_from_json
    post_data = JSON.parse(File.read(Rails.root + 'spec/data/posts.json'))


    post_data.map { |json| RedditPost.new(json) }
  end

  let(:posts) { load_posts_from_json }
  let(:service) { CalculateBestTimeToPost.new(posts) }

  it 'does a thing' do
    expect(service.call.strftime(CalculateBestTimeToPost::TIME_FORMAT)).to eq 'Saturday 08am'
  end
end
