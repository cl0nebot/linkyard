class DuplicateChecker
  include Sidekiq::Worker

  def perform(link_id)
    @link = Link.find_by_id(link_id)
    return unless @link.present?

    @link.update_attributes!(possible_duplicate: true) if Link.where(url: @link.url, digest: @link.digest).count > 1
  end
end
