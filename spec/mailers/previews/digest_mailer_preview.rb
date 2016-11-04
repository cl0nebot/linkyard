# Preview all emails at http://localhost:3000/rails/mailers/digest_mailer
class DigestMailerPreview < ActionMailer::Preview
  def weekly
    type = Weekly::Digest::PROGRAMMING
    return DigestMailer.weekly(Weekly::Digest.new(type, issue: 175), Subscriber.for_email.where(digest: type).last)

    # type = Weekly::Digest::CSHARP
    # return DigestMailer.weekly(Weekly::Digest.new(type, issue: 107), Subscriber.for_email.where(digest: type).last)

    # type = Weekly::Digest::ELIXIR
    # return DigestMailer.weekly(Weekly::Digest.new(type, issue: 50), Subscriber.for_email.where(digest: type).last)

    # type = Weekly::Digest::REACT
    # return DigestMailer.weekly(Weekly::Digest.new(type, issue: 46), Subscriber.for_email.where(digest: type).last)
  end
end
