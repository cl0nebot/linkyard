class CreateLinkTags < ActiveRecord::Migration
  def change
    create_table :link_tags do |t|
      t.belongs_to :link, null: false
      t.belongs_to :tag, null: false
      t.timestamps
    end
  end
end
