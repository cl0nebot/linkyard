class CreateBuilders < ActiveRecord::Migration
  def change
    create_table :builders do |t|
      t.belongs_to :user
      t.string :type, :null => false
      t.string :configuration
      t.timestamps
    end
  end
end
