class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.string :digest
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
