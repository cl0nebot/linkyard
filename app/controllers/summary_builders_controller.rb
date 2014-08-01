class SummaryBuildersController < ApplicationController
  layout "account"

  def index
    @summary_builders = current_user.summary_builders.order(created_at: :desc)
  end

  def create
  end

  def new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end
end
