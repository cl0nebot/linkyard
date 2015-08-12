class CreateSubscribers < ActiveRecord::Migration
  def self.up
    create_table :subscribers, :id => false  do |t|
      t.uuid :id, :primary_key => true

      t.string :email
      t.string :digest, limit: 20

      t.timestamps
    end
    add_index :subscribers, :id
  end

  def self.down
    drop_table :subscribers
  end
end
