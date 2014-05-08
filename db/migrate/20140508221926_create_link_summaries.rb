class CreateLinkSummaries < ActiveRecord::Migration
  def change
    create_table :links_summaries do |t|
      t.belongs_to :link
      t.belongs_to :summary
      t.timestamps
    end
  end
end
