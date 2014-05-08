class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.belongs_to :user
      t.string :type, :null => false
      t.string :configuration
      t.timestamps
    end
  end
end
