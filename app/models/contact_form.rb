class ContactForm < MailForm::Base
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :digest
  attribute :nickname,  :captcha  => true

  def headers
    {
      :subject => "Contact from #{digest}digest.net",
      :to => "jakub.chodounsky@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end
