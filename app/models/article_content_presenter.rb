class ArticleContentPresenter
  def initialize(article_content, available_interactions, available_digests)
    @article_content = article_content
    @available_interactions = available_interactions
    @available_digests = available_digests
  end

  def to_h
    { link_submission: @article_content.merge(available_interactions_hash).merge(available_digests_hash) }
  end

  private
  def available_interactions_hash
    { link_interactions: @available_interactions.map { |i| { id: i.id, name: i.class.humanized_name, checked: "0" } }.to_a }
  end

  def available_digests_hash
    { digests: @available_digests }
  end
end
