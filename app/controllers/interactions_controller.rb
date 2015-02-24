class InteractionsController < ApplicationController
  layout "account"

  skip_before_action :authenticate_user!, only: :authenticate
  before_action :find_interaction_and_redirect_if_not_exists, only: [:edit, :update, :destroy]

  def index
    @interactions = current_user.interactions.order(created_at: :desc)
  end

  def new
    if request.xhr? && params[:type]
      @interaction = Interaction.new_by_name(params[:type])
      render view_for(params[:type]), layout: false
    else
      @interaction = current_user.interactions.build
    end
  end

  def edit
  end

  def create
    @interaction = Interaction.new_by_name(params[:type], interaction_params_from(params))
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
  def find_interaction_and_redirect_if_not_exists
    unless @interaction = current_user.interactions.find_by_id(params[:id])
      flash[:error] = "The interaction doesn't exists."
      redirect_to interactions_path
    end
  end

  def interaction_params_from(params)
    permitted_params = params[params[:type].underscore].present? ? params[params[:type].underscore].permit! : {}
    Interaction.prepare_parameters_by_name(params[:type], permitted_params)
  end

  def view_exists?(type)
    File.exists?(Rails.root.join("app", "views", params[:controller], "_#{type}.html.erb"))
  end

  def view_for(type)
    view_exists?(type.underscore) ? '_' + type.underscore : '_generic_interaction'
  end
end
