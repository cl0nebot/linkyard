class DashboardController < ApplicationController
  before_action :only_administrator

  def index
    @subscriber_stats = Dashboard.subscriber_stats
    @future_digests = Dashboard.digests(params[:week_offset].present? ? params[:week_offset].to_i : 1)
    @subscribers_for_email = Subscriber.for_email.size
    @unsubscribed = Dashboard.unsubscribed
  end

  def sponsors
    @advertisement_stats = Weekly::Digest::TYPES.map { |type| AdvertisementForm.new(digest: type) }
    @sponsor_stats = Dashboard.sponsor_stats
  end
end
