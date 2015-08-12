class SubscribersController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!

  def create
    subscriber = Subscriber.new(params[:subscriber].permit(:email, :digest))
    if subscriber.save
      flash[:success] = "You've been subscribed successfully!"
      redirect_to :back
    else
      flash[:error] = subscriber.errors.full_messages.to_sentence
      redirect_to :back
    end
  end
end
