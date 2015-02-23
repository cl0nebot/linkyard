class CreateBestTimes < ActiveRecord::Migration
  def change
    create_table :best_times do |t|
      t.string :interaction
      t.integer :time

      t.timestamps
    end
  end
end
