class LinkSearch
  def initialize(search_term, user)
    @search_term = search_term
    @user = user
  end

  def call
    documents = PgSearch.multisearch(@search_term)
    documents.map { |document| @user.links.find(document.searchable_id) }.uniq
  end
end