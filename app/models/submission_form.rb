class SubmissionForm < MailForm::Base
  attribute :name,      :validate => true
  attribute :url,       :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :description
  attribute :digest
  attribute :nickname,  :captcha  => true

  def headers
    {
      :subject => "Submission request from #{digest} digest",
      :to => "jakub.chodounsky@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end
