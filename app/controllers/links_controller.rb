class LinksController < ApplicationController
  def index
    @links = Link.order(:created_at => :desc)
  end

  def new
    @link = current_user.links.build
    @interactions = current_user.interactions
    @link_interactions = @interactions.map { |interaction| LinkInteraction.new(:interaction => interaction) }
  end

  def create
    @link = current_user.links.build(params[:link].permit(:url, :title))
    @link.link_interactions = create_link_interactions_from(params[:link][:link_interactions] || {})

    if @link.save_and_publish
      flash[:success] = "Link added successfully."
      redirect_to links_path
    else
      @interactions = current_user.interactions
      @link_interactions = @link.link_interactions
      render :new
    end
  end

  protected
  def create_link_interactions_from(link_interaction_params)
    link_interaction_params.select { |_, checked| checked == "1"}.map do |interaction_id, _|
      LinkInteraction.new(:interaction => current_user.interactions.find(interaction_id), :status => :pending)
    end
  end
end
