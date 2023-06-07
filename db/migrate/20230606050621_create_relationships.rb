class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.references :mentioning, null: false, foreign_key: { to_table: :reports}
      t.references :mentioned, null: false, foreign_key: { to_table: :reports}

      t.timestamps
    end
  end
end
