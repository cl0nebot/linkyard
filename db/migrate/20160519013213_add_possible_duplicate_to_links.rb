class AddPossibleDuplicateToLinks < ActiveRecord::Migration
  def change
    add_column :links, :possible_duplicate, :boolean, default: false
  end
end
