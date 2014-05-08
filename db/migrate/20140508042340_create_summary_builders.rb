class CreateSummaryBuilders < ActiveRecord::Migration
  def change
    create_table :summary_builders do |t|
      t.belongs_to :summary
      t.belongs_to :builder
      t.timestamps
    end
  end
end
