class LinksController < ApplicationController
  before_filter :build_link_submission, only: [:new, :create]
  before_filter :find_link_and_redirect_if_not_exists, only: [:show, :destroy]

  def index
    @links = Link.order(created_at: :desc)
  end

  def new
  end

  def create
    url = params[:link_submission][:url]
    title = params[:link_submission][:title]
    tags = params[:link_submission][:tags]
    description = params[:link_submission][:description]
    content = params[:link_submission][:content]

    if @link_submission.save(url: url, title: title, tags: tags, description: description, content: content, link_interaction_ids: extract_link_interaction_ids(params))
      flash[:success] = "Link added successfully."
      redirect_to links_path
    else
      render :new
    end
  end

  def show
  end

  def destroy
    @link.destroy
    redirect_to links_path
  end

  private
  def build_link_submission
    @link_submission = LinkSubmission.new_from_user(current_user)
  end

  def extract_link_interaction_ids(params)
    (params[:link_submission][:link_interactions] || {}).select { |_, checked| checked == "1" }
  end

  def find_link_and_redirect_if_not_exists
    unless @link = current_user.links.find_by_id(params[:id])
      flash[:error] = "The selected link doesn't exist."
      redirect_to links_path
    end
  end
end
