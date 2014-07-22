class AddDescriptionAndContentToLinks < ActiveRecord::Migration
  def change
    add_column :links, :description, :text
    add_column :links, :content, :text
  end
end
