class LinksController < ApplicationController
  def index
    @links = Link.order(:created_at => :desc)
  end

  def show
    
  end

  def new
    @link = current_user.links.build
    @interactions = current_user.interactions
    @link_interactions = @interactions.map { |interaction| LinkInteraction.new(:interaction => interaction) }
  end

  def create
    @link = current_user.links.build(params[:link].permit(:url, :title))
    @link.link_interactions = create_link_interactions_from(params[:link][:link_interactions])

    if @link.save_and_publish
      flash[:success] = "Link added successfully."
      redirect_to links_path
    else
      @interactions = current_user.interactions
      @link_interactions = @link.link_interactions
      render :new
    end
  end

  def destroy
  end

  protected
  def create_link_interactions_from(link_interaction_params)
    link_interaction_params.select { |interaction_id, checked| checked == "1"}.map do |interaction_id, checked|
      LinkInteraction.new(:interaction => Interaction.where(:user => current_user).find(interaction_id))
    end
  end
end         
