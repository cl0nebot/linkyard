class SubscribersController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!

  layout false

  def create
    digest = params[:subscriber][:digest]
    subscriber = Subscriber.where(digest: digest).where("unsubscribed_at IS NOT NULL OR confirmed_at IS NULL").find_by_email(params[:subscriber][:email]) || Subscriber.new(params[:subscriber].permit(:email, :digest))

    if subscriber.unsubscribed_at.present?
      subscriber.update_attributes!(unsubscribed_at: nil)
      flash[:success] = "You've been subscribed successfully"
    else
      if subscriber.save
        SubscriberMailer.confirm(subscriber).deliver
        flash[:success] = "We sent you a confirmation email – please confirm your email address"
      else
        flash[:error] = subscriber.errors.full_messages.to_sentence
      end
    end

    redirect_to :back
  end

  def confirm
    subscriber = Subscriber.find_by(id: params[:subscriber_id]) if params[:subscriber_id]
    if subscriber.present?
      subscriber.update_attributes!(confirmed_at: Time.zone.now)
      flash[:success] = "Your email was confirmed! You are all set to receive our newsletter"
    else
      flash[:error] = "This subscriber doesn't exist"
    end

    redirect_to root_path
  end

  def unsubscribe
    subscriber = Subscriber.find_by(id: params[:subscriber_id]) if params[:subscriber_id]
    flash[:error] = "This subscriber doesn't exist" and return unless subscriber

    subscriber.update_attributes!(unsubscribed_at: Time.zone.now)
    flash[:success] = "We are sad that you are going away, but you are unsubscribed from the newsletter"
  end
end
