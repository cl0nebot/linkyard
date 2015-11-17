class InboundEmailsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def mandrill
    events = JSON.parse(params[:mandrill_events]) if params[:mandrill_events]

    if events.present?
      events.each do |event|
        message = event[:msg]
        to = message[:to]
        from = "#{message[:from_email]} (#{message[:from_name]})"
        subject = message[:subject]
        text = message[:text]
        spam_score = message[:spam_report][:score]

        InboundMailer.inbound(to, from, subject, text).deliver_now unless spam_score > 5
      end
    end

    head :ok
  end
end
