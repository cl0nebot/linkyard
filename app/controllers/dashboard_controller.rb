class DashboardController < ApplicationController
  before_action :only_administrator

  def index
    @subscriber_stats = Dashboard.subscriber_stats
    @future_digests = Dashboard.future_digests
    @subscribers_for_email = Subscriber.where(digest: Weekly::Digest::TYPES).for_email.size
    @unsubscribed = Dashboard.unsubscribed
  end

  private
  def only_administrator
    redirect_to root_path and return false unless current_user.id == 7
  end
end
