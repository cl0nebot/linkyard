class AddScheduledTimeToLinkInteraction < ActiveRecord::Migration
  def change
    add_column :link_interactions, :best_scheduled_time, :datetime
  end
end
