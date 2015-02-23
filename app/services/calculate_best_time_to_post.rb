require 'chronic'

class CalculateBestTimeToPost
  TIME_FORMAT = '%A %-l%P'

  def initialize(posts)
    @posts = posts
  end

  def call
    Chronic.parse("Next #{best_time}")
  end

  private

  def best_time
    @posts
      .group_by { |post| post.created_at.strftime(TIME_FORMAT) }
      .max_by { |_, posts| posts.map(&:score).sum * posts.size }
      .first
  end

  def best_times
    @posts
      .group_by { |post| post.created_at.strftime(TIME_FORMAT) }
      .map { |timestamp, posts| [timestamp, posts.map(&:score).sum, posts.size] }
      .sort_by { |a, b, c| b }
  end
end
