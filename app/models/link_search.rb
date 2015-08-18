class LinkSearch
  def initialize(search_term, links)
    @search_term = search_term
    @links = links
  end

  def call
    documents = PgSearch.multisearch(@search_term)
    @links.select { |link| documents.any? { |document| link.id == document.searchable_id }}
  end
end
