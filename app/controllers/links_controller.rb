class LinksController < ApplicationController
  def index
    @links = Link.order(created_at: :desc)
  end

  def new
    @link_submission = LinkSubmission.new(user: current_user)
  end

  def create
    @link_submission = LinkSubmission.new_from(current_user, params)

    if @link_submission.save
      flash[:success] = "Link added successfully."
      redirect_to links_path
    else
      render :new
    end
  end
end
