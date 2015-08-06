class DigestsController < ApplicationController
  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!

  layout "digest"

  def index
    @links = Link.for_digest
  end

  def show
  end

  def subscribe
  end
end
