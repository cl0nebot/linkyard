class InteractionsController < ApplicationController
  def create
  end

  def show
  end

  def index
  end

  def new
    if request.xhr? && params[:type]
      interaction = Interaction.new_by_type(params[:type])
      render view_for(params[:type]), :layout => false
    else
      @interaction = current_user.interactions.build
    end
  end

  def edit
  end

  def delete
  end

  protected
  def view_exists?(type)
    File.exists?(Rails.root.join("app", "views", params[:controller], "#{type}.html.erb"))
  end

  def view_for(type)
    view_exists?(type.underscore) ? type.underscore : 'generic_interaction'
  end
end
