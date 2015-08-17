class DigestsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!
  before_action :initialize_subscriber, only: [:index, :show, :home]

  layout "digest"

  def index
    @digests = Weekly::Digest.all.reverse
  end

  def show
    return unless Weekly::Digest.valid_issue?(params[:id].to_i)

    @digest = Weekly::Digest.new(issue: params[:id].to_i)
  end

  def search
    @links = LinkSearch.new(params[:search], Link.digestable).call if params[:search].present?
   end

  def feed
    @digests = Weekly::Digest.take(10).reverse
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  def home
    @latest_issue = Weekly::Digest.issue_from(Time.zone.now)
  end

  private
  def initialize_subscriber
    @subscriber = Subscriber.new(digest: Weekly::Digest::PROGRAMMING)
  end
end
