class DigestsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!

  layout "digest"

  # 92 - 118

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
end
