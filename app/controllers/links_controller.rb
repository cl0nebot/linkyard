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
    @link.link_interactions = params[:link][:link_interactions].select { |interaction_id, checked| checked == "1"}.map do |interaction_id, checked|
      LinkInteraction.new(:interaction => Interaction.find(interaction_id))
    end
    if @link.save
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
end         
