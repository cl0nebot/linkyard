class AddUnsubscribedAtToSubscribers < ActiveRecord::Migration
  def up
    add_column :subscribers, :unsubscribed_at, :datetime
  end

  def down
    remove_column :subscribers, :unsubscribed_at
  end
end
