class LinksController < ApplicationController
  before_filter :build_link_submission, only: [:new, :create]
  before_filter :find_link_and_redirect_if_not_exists, only: [:show, :destroy]

  def index
    @links = Link.order(created_at: :desc)
  end

  def new
    respond_to do |format|
      format.html
      format.json do
        url = params[:url]
        if url.present?
          article_content = ArticleContentFetcher.new(url).fetch
          without_html_escaping_in_json do
            render json: ArticleContentPresenter.new(article_content, current_user.interactions).to_h, status: :ok
          end
        else
          render json: { error: "Parameter url is missing" }, status: :bad_request
        end
      end
    end
  end

  def create
    url = params[:link_submission][:url]
    title = params[:link_submission][:title]
    tags = params[:link_submission][:tags]
    description = params[:link_submission][:description]
    content = params[:link_submission][:content]
    saved = @link_submission.save(url: url, title: title, tags: tags, description: description, content: content, link_interaction_ids: extract_link_interaction_ids(params))

    respond_to do |format|
      format.html do
        if saved
          flash[:success] = "Link added successfully."
          redirect_to links_path
        else
          render :new
        end
      end
      format.json do
        if saved
          head :created
        else
          render json: { error: @link_submission.errors.full_messages.to_sentence }, status: :not_acceptable
        end
      end
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

  def without_html_escaping_in_json(&block)
    ActiveSupport.escape_html_entities_in_json = false
    result = yield
    ActiveSupport.escape_html_entities_in_json = true
    result
  end
end
