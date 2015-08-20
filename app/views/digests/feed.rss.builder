xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Weekly #{@digest_type.capitalize} Digest"
    xml.author "Jakub Chodounsky"
    xml.description "The list of the most awesome #{@digest_type.capitalize} links distributed weekly."
    xml.link "http://#{@digest_type}digest.net"
    xml.language "en"

    @digests.each do |digest|
      xml.item do
        xml.title "Weekly #{digest.type.capitalize} Digest Issue ##{digest.issue}"
        xml.author "Jakub Chodounsky"
        xml.pubDate digest.to.to_s(:rfc822)
        xml.link digest_url(digest.issue)
        xml.guid digest_url(digest.issue)
        xml.description render partial: "rss", locals: { digest: digest }, formats: "html"
      end
    end
  end
end
