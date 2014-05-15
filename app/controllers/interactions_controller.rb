class InteractionsController < ApplicationController
  def index
    @interactions = Interaction.order(:created_at => :desc)
  end

  def show
    
  end

  def new
    if request.xhr? && params[:type]
      @interaction = Interaction.new_by_type(params[:type])
      render view_for(params[:type]), :layout => false
    else
      @interaction = current_user.interactions.build
    end
  end

  def edit
    @interaction = Interaction.find(params[:id])
  end
  
  def create
    @interaction = Interaction.new_by_type(params[:type], params[params[:type].underscore].permit!)
    @interaction.user = current_user
    
    if @interaction.save
      flash[:success] = "Interaction added successfully."
      redirect_to interactions_path
    else
      render :new
    end
  end

  def update
    # should check whether user has rights to update this interaction?
    @interaction = Interaction.find(params[:id])
    
    if @interaction.update(params[params[:type].underscore].permit!)
      flash[:success] = "Interaction updated successfully."
      redirect_to interactions_path
    else
      render :edit
    end
  end

  def destroy
    # should check whether user has rights to delete this interaction?
    Interaction.destroy(params[:id])
    redirect_to interactions_path
  end

  protected
  def view_exists?(type)
    File.exists?(Rails.root.join("app", "views", params[:controller], "_#{type}.html.erb"))
  end

  def view_for(type)
    view_exists?(type.underscore) ? '_' + type.underscore : '_generic_interaction'
  end
end
