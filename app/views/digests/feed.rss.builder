xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Weekly #{digest_name(@digest_type)} Digest"
    xml.author "Jakub Chodounsky"
    xml.description "The list of the most awesome #{digest_name(@digest_type)} links distributed weekly."
    xml.link "https://#{@digest_type}digest.net"
    xml.language "en"

    @digests.each do |digest|
      xml.item do
        xml.title "Weekly #{digest_name(digest.type)} Digest Issue ##{digest.issue}"
        xml.author "Jakub Chodounsky"
        xml.pubDate digest.to.to_s(:rfc822)
        xml.link digest_url(digest.issue)
        xml.guid digest_url(digest.issue)
        xml.description render partial: "rss", locals: { digest: digest }, formats: "html"
      end
    end
  end
end
