class LinksController < ApplicationController
  before_filter :build_link_submission, only: [:new, :create]
  before_filter :find_link_and_redirect_if_not_exists, only: [:show, :destroy]

  def index
    respond_to do |format|
      @links = paginated_user_links
      format.html
      format.json do
        render json: { links: @links }
      end
    end
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

    respond_to do |format|
      format.html do
        active_interactions = (params[:link_submission][:link_interactions] || {}).select { |_, checked| checked == "1" }
        if @link_submission.save(url: url, title: title, tags: tags, description: description, content: content, link_interaction_ids: active_interactions)
          flash[:success] = "Link added successfully."
          redirect_to links_path
        else
          render :new
        end
      end
      format.json do
        active_interactions = (params[:link_submission][:link_interactions] || {}).select { |o| o[:checked] == "1" }
        if @link_submission.save(url: url, title: title, tags: tags, description: description, content: content, link_interaction_ids: active_interactions)
          render json: @link_submission
        else
          render json: { error: @link_submission.errors.full_messages.to_sentence }, status: :not_acceptable
        end
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: {link: @link} }
    end
  end

  def destroy
    @link.destroy
    redirect_to links_path
  end

  def search
    if params[:search].empty?
      @links = paginated_user_links
    else
      @links = LinkSearch.new(params[:search], current_user).call
    end
    render :index
  end

  private
  def build_link_submission
    @link_submission = LinkSubmission.new_from_user(current_user)
  end

  def find_link_and_redirect_if_not_exists
    unless @link = current_user.links.find_by_id(params[:id])
      respond_to do |format|
        format.html do
          flash[:error] = "The selected link doesn't exist."
          redirect_to links_path
        end
        format.json do
          render json: { error: "The selected link does not exist" }, status: :not_found
        end
      end
    end
  end

  def without_html_escaping_in_json(&block)
    ActiveSupport.escape_html_entities_in_json = false
    result = yield
    ActiveSupport.escape_html_entities_in_json = true
    result
  end

  def paginated_user_links
    current_user.links.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end
end
