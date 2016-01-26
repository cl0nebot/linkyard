class AddClicksToLinks < ActiveRecord::Migration
  def change
    add_column :links, :clicks, :integer, default: 0, null: false
  end
end
