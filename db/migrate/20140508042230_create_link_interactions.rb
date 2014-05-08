class CreateLinkInteractions < ActiveRecord::Migration
  def change
    create_table :link_interactions do |t|
      t.belongs_to :interaction
      t.belongs_to :links
      t.timestamps
    end
  end
end
