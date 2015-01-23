class ArticleContentPresenter
  def initialize(article_content, available_interactions)
    @article_content = article_content
    @available_interactions = available_interactions
  end

  def to_h
    { link_submission: @article_content.merge(available_interactions_hash) }
  end

  private
  def available_interactions_hash
    { link_interactions: @available_interactions.map { |i| { id: i.id, name: i.name, checked: "0" } }.to_a }
  end
end
