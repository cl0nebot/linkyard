class DashboardController < ApplicationController
  before_action :only_administrator

  def index
    @subscriber_stats = Dashboard.subscriber_stats
    @future_digests = Dashboard.future_digests
    @subscribers_for_email = Subscriber.for_email.size
    @unsubscribed = Dashboard.unsubscribed
  end

  def sponsors
    @sponsor_stats = Dashboard.sponsor_stats
  end
end
