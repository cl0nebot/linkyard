class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.belongs_to :user,  :null => false
      t.string :type, :null => false
      t.text :configuration
      t.timestamps
    end
  end
end
