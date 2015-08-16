class SubscribersController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!

  layout "digest"

  def create
    subscriber = Subscriber.new(params[:subscriber].permit(:email, :digest))
    if subscriber.save
      flash[:success] = "You've been subscribed successfully"
      redirect_to :back
    else
      flash[:error] = subscriber.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  def unsubscribe
    subscriber = Subscriber.find(params[:subscriber_id]) if params[:subscriber_id]
    flash[:error] = "This subscriber doesn't exist" and return unless subscriber

    subscriber.update_attributes!(unsubscribed_at: Time.zone.now)
    flash[:success] = "We are sad that you are going away, but you are unsubscribed from the newsletter"
  end
end