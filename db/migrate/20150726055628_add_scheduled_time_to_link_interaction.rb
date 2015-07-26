class AddScheduledTimeToLinkInteraction < ActiveRecord::Migration
  def change
    add_column :link_interactions, :scheduled_time, :datetime
  end
end
