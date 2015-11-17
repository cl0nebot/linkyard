class InboundMailer < ActionMailer::Base
  default from: "inbound@programmingdigest.net"

  def inbound(to, from, subject, text)
    @to = to
    @from = from
    @subject = subject
    @text = text

    mail to: "jakub.chodounsky@gmail.com", subject: "Inbound email from #{@from}"
  end
end
