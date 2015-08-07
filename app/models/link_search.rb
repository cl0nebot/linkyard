class LinkSearch
  def initialize(search_term, links)
    @search_term = search_term
    @links = links
  end

  def call
    documents = PgSearch.multisearch(@search_term)
    documents.map { |document| @links.find(document.searchable_id) }.uniq
  end
end
