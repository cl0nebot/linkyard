class LinksController < ApplicationController
  def new
    @link = current_user.links.build
  end

  def create
    @link = current_user.links.build(params[:link].permit(:url, :title))
    if current_user.save
      flash[:success] = "Link added successfully."
      redirect_to links_path
    else
      render :new
    end
  end

  def index
    @links = Link.order(:created_at => :desc)
  end
end         
