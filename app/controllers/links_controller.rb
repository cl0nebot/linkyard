class LinksController < ApplicationController
  before_filter :build_link_submission, :except => :index

  def index
    @links = Link.order(created_at: :desc)
  end

  def new
  end

  def create
    url = params[:link_submission][:url]
    title = params[:link_submission][:title]
    tags = params[:link_submission][:tags]

    if @link_submission.save(url: url, title: title, tags: tags, link_interaction_ids: extract_link_interaction_ids(params))
      flash[:success] = "Link added successfully."
      redirect_to links_path
    else
      render :new
    end
  end

  private
  def build_link_submission
    @link_submission = LinkSubmission.new_from_user(current_user)
  end

  def extract_link_interaction_ids(params)
    (params[:link_submission][:link_interactions] || {}).select { |_, checked| checked == "1" }
  end
end
