class AddConfirmedAtToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :confirmed_at, :datetime
    Subscriber.update_all(confirmed_at: Time.parse("2000-01-01 11:00"))
  end

end
