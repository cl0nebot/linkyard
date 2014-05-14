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
  end
  
  def create
    @interaction = Interaction.new_by_type(params[:type], params[params[:type].underscore].permit!)
    @interaction.user = current_user
    
    if @interaction.save
      flash[:success] = "Interaction added successfully."
      redirect_to interactions_path
    else
      render view_for(params[:type])
    end
  end

  def update
    
  end

  def destroy
  end

  protected
  def view_exists?(type)
    File.exists?(Rails.root.join("app", "views", params[:controller], "#{type}.html.erb"))
  end

  def view_for(type)
    view_exists?(type.underscore) ? type.underscore : 'generic_interaction'
  end
end
