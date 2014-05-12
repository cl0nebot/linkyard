class CreateBuilders < ActiveRecord::Migration
  def change
    create_table :builders do |t|
      t.belongs_to :user, :null => false
      t.string :type, :null => false
      t.text :configuration
      t.timestamps
    end
  end
end
