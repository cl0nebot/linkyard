class DigestsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!
  before_action :set_digest_type
  before_action :initialize_subscriber, only: [:index, :show, :home]

  layout "digest"

  def index
    @digests = Weekly::Digest.all(@digest_type).reverse
  end

  def show
    return unless Weekly::Digest.valid_issue?(@digest_type, params[:id].to_i)

    @digest = Weekly::Digest.new(@digest_type, issue: params[:id].to_i)
  end

  def search
    @links = LinkSearch.new(params[:search], Link.digestable(@digest_type)).call if params[:search].present?
   end

  def feed
    @digests = Weekly::Digest.take(@digest_type, 10).reverse
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  def home
    @latest_issue = Weekly::Digest.issue_from(@digest_type, Time.zone.now)
  end

  private
  def set_digest_type
    @digest_type = Weekly::Digest::PROGRAMMING
  end

  def initialize_subscriber
    @subscriber = Subscriber.new(digest: @digest_type)
  end
end
