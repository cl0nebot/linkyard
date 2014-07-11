class AddResultToLinkInteractions < ActiveRecord::Migration
  def change
    add_column :link_interactions, :status, :string
    add_column :link_interactions, :status_description, :string
  end
end
