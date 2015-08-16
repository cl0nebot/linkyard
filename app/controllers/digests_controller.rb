class DigestsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!

  around_filter :set_time_zone

  layout "digest"

  def index
    @subscriber = Subscriber.new(digest: Weekly::Digest::PROGRAMMING)
    @digests = Weekly::Digest.all.reverse
  end

  def show
    return unless Weekly::Digest.valid_issue?(params[:id].to_i)

    @subscriber = Subscriber.new(digest: Weekly::Digest::PROGRAMMING)
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

  private
  def set_time_zone
    Time.use_zone("Wellington") do
      yield
    end
  end
end
