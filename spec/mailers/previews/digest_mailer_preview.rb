# Preview all emails at http://localhost:3000/rails/mailers/digest_mailer
class DigestMailerPreview < ActionMailer::Preview
  def weekly
    type = Weekly::Digest::PROGRAMMING
    DigestMailer.weekly(Weekly::Digest.new(type, issue: 119), Subscriber.for_email.where(digest: type).last)
  end
end
