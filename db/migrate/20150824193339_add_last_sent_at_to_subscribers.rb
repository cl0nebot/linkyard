class AddLastSentAtToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :last_sent_at, :datetime
  end
end
