# Preview all emails at http://localhost:3000/rails/mailers/digest_mailer
class DigestMailerPreview < ActionMailer::Preview
  def weekly
    DigestMailer.weekly(Weekly::Digest::PROGRAMMING)
  end
end
