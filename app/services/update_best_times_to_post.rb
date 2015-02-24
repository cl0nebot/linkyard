class UpdateBestTimesToPost
  INTERACTIONS_TO_CHECK = {
    RedditInteraction => TopPosts::GetTopRedditPosts
  }

  def self.run
    new.run
  end

  def run
    INTERACTIONS_TO_CHECK.each do |interaction, post_getter|
      BestTime.create!(
        interaction: interaction.to_s,
        time: CalculateBestTimeToPost.new(post_getter.new.call).call
      )
    end
  end
end
