class CreateShareRequests < ActiveRecord::Migration
  def change
    create_table :share_requests do |t|
      t.belongs_to :link, null: false
      t.string :twitter_contact
      t.string :email_contact
    end
  end
end
