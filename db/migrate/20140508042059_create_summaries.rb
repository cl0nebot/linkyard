class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.belongs_to :user
      t.timestamps
    end

    create_table :links_summaries, :id => false do |t|
      t.belongs_to :links
      t.belongs_to :part   
      t.timestamps
    end
  end
end
