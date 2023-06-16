class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :report_mentions do |t|
      t.references :mentioning, null: false, foreign_key: { to_table: :reports}
      t.references :mentioned, null: false, foreign_key: { to_table: :reports}
      t.index ["mentioning_id", "mentioned_id"], name: "index_mentioning_on_mentioned", uniq: true
      t.timestamps
    end
  end
end
