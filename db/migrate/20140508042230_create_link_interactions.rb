class CreateLinkInteractions < ActiveRecord::Migration
  def change
    create_table :link_interactions do |t|
      t.belongs_to :interaction, :null => false
      t.belongs_to :link, :null => false
      t.timestamps
    end
  end
end
