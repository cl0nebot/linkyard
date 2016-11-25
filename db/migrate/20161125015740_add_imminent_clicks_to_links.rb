class AddImminentClicksToLinks < ActiveRecord::Migration
  def change
    add_column :links, :imminent_clicks, :integer, default: 0
  end
end
