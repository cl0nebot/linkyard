class ShareRequest < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :link

  def tweet_text
    "Hi #{twitter_contact} - your article #{link.title} was featured in #{link.digest.capitalize} Digest. Please, share it by #{tweet_url}."
  end

  def tweet_url
    text = CGI.escape("#{link.title.strip} featured in #{link.digest.capitalize} Digest at")
    issue = Weekly::Digest.issue_from(link.digest, link.created_at)
    url = Rails.application.routes.url_helpers.digest_url(issue, host: Weekly::Digest.domain_from(link.digest))
    "https://twitter.com/intent/tweet?text=#{text}&url=#{url}&via=#{twitter_username(link.digest)}"
  end
end
