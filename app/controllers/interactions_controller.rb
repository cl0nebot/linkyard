class InteractionsController < ApplicationController
  skip_before_action :authenticate_user!, :only => :authenticate
  before_action :find_interaction_and_check_permissions, :only => [:edit, :update, :destroy]
  
  def index
    @interactions = current_user.interactions.order(:created_at => :desc)
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
  end
  
  def create
    @interaction = Interaction.new_by_type(params[:type], interaction_params_from(params))
    @interaction.user = current_user
    
    if @interaction.save
      flash[:success] = "Interaction added successfully."
      redirect_to interactions_path
    else
      render :new
    end
  end

  def update
    if @interaction.update(interaction_params_from(params))
      flash[:success] = "Interaction updated successfully."
      redirect_to interactions_path
    else
      render :edit
    end
  end

  def destroy
    @interaction.destroy
    redirect_to interactions_path
  end


  protected
  def find_interaction_and_check_permissions
    unless @interaction = current_user.interactions.find_by_id(params[:id])
      flash[:error] = "You are not authorized to perform this action."
      redirect_to interactions_path
    end
  end

  def interaction_params_from(params)
    params[params[:type].underscore].permit! if params[params[:type].underscore].present? # instead of permit everything use a helper method on models with defined permitted paramters
  end

  def view_exists?(type)
    File.exists?(Rails.root.join("app", "views", params[:controller], "_#{type}.html.erb"))
  end

  def view_for(type)
    view_exists?(type.underscore) ? '_' + type.underscore : '_generic_interaction'
  end
end
