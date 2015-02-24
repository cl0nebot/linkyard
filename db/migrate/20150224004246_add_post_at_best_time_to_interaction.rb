class AddPostAtBestTimeToInteraction < ActiveRecord::Migration
  def change
    add_column :interactions, :post_at_best_time, :boolean
  end
end
