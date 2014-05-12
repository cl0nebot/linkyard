class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.belongs_to :user, :null => false
      t.string :title, :null => false
      t.string :url, :null => false
      t.timestamps
    end
  end
end
