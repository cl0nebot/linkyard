class CreateSummaryBuilders < ActiveRecord::Migration
  def change
    create_table :summary_builders do |t|
      t.belongs_to :summary, :null => false
      t.belongs_to :builder, :null => false
      t.timestamps
    end
  end
end
