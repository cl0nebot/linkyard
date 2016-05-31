class ShareRequest < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :link

  def tweet_text
    issue = Weekly::Digest.issue_from(link.digest, link.created_at) + 1
    url = Rails.application.routes.url_helpers.digest_url(issue, host: Weekly::Digest.domain_from(link.digest))
    ".@#{twitter_contact} \"#{title(link)}\" was featured in last digest at #{url}"
  end

  private
  def title(link)
    title_length = 65
    if link.title.length > title_length
      link.title.slice(0..(title - 3)) + "..."
    else
      link.title
    end
  end

  # not used at the moment
  def tweet_url
    text = CGI.escape("#{link.title.strip} featured in #{link.digest.capitalize} Digest at")
    issue = Weekly::Digest.issue_from(link.digest, link.created_at) + 1
    url = Rails.application.routes.url_helpers.digest_url(issue, host: Weekly::Digest.domain_from(link.digest))
    "https://twitter.com/intent/tweet?text=#{text}&url=#{url}&via=#{twitter_username(link.digest)}"
  end
end
