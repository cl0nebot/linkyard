class ShareRequestsController < ApplicationController
  before_action :only_administrator

  def new
    @link = Link.find(params[:id])
    @share_request = @link.share_requests.build
  end

  def create
    @link = Link.find(params[:id])
    link_issue = Weekly::Digest.issue_from(@link.digest, @link.created_at)
    current_issue = Weekly::Digest.issue_from(@link.digest, Time.zone.now)
    share_request = @link.share_requests.new(params[:share_request].permit(:twitter_contact))

    if share_request.save
      begin
        Tweet.new(share_request.tweet_text, current_user, @link.digest).call
        flash[:notice] = "Share request created successfully"
      rescue Twitter::Error => e
        flash[:error] = e.message
      end

      redirect_to controller: "dashboard", action: "index", week_offset: link_issue - current_issue + 1
    else
      render :new
    end
  end
end
