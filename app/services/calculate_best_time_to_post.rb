require 'chronic'

class CalculateBestTimeToPost
  TIME_FORMAT = '%A %I%P'

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
      .max_by { |_, posts| posts.map(&:score).sum }
      .first
  end
end
