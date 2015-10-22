class DashboardController < ApplicationController
  before_action :only_administrator

  def index
    @subscriber_stats = Dashboard.subscriber_stats
    @future_digests = Dashboard.future_digests
    @pending_interactions = Dashboard.pending_interactions
  end

  private
  def only_administrator
    redirect_to root_path and return false unless current_user.id == 7
  end
end
