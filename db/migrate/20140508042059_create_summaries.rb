class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.belongs_to :user, :null => false
      t.timestamps
    end
  end
end
