class AddDefaultToLinkTags < ActiveRecord::Migration
  def change
    add_column :link_tags, :default, :boolean, default: false
  end
end
