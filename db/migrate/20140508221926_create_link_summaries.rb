class CreateLinkSummaries < ActiveRecord::Migration
  def change
    create_table :links_summaries do |t|
      t.belongs_to :link, :null => false
      t.belongs_to :summary, :null => false
      t.timestamps
    end
  end
end
