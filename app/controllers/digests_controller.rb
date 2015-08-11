class DigestsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!

  layout "digest"

  def index
    @digests = Weekly::Digest.all.reverse
  end

  def show
    flash[:error] = "The number of the digest is invalid" and return unless Weekly::Digest.valid_issue?(params[:id].to_i)
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
end
