class ShareRequest < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :link

  def tweet_text
    "@#{twitter_contact} \"#{title(link)}\" was featured in last digest. Share it #{tweet_url}"
  end

  def tweet_url
    text = CGI.escape("#{link.title.strip} featured in #{link.digest.capitalize} Digest at")
    issue = Weekly::Digest.issue_from(link.digest, link.created_at)
    url = Rails.application.routes.url_helpers.digest_url(issue, host: Weekly::Digest.domain_from(link.digest))
    "https://twitter.com/intent/tweet?text=#{text}&url=#{url}&via=#{twitter_username(link.digest)}"
  end

  private
  def title(link)
    if link.title.length > 79
      link.title.slice(0..76) + "..."
    else
      link.title
    end
  end
end
