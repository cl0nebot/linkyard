# Preview all emails at http://localhost:3000/rails/mailers/inbound_mailer
class InboundMailerPreview < ActionMailer::Preview
  def inbound
    InboundMailer.inbound("jakub@programmingdigest.net", "test@test.com (Johnny)", "Test subject", "Random text as a body") 
  end
end
