class CreateSummaryBuilders < ActiveRecord::Migration
  def change
    create_table :summary_builders do |t|
      t.belongs_to :user, null: false
      t.string :type, null: false
      t.text :confifuration

      t.timestamps
    end
  end
end
