class AddUniqueKeyToRelationships < ActiveRecord::Migration[7.0]
  def change
    add_index  :relationships, [:mentioning_id, :mentioned_id], unique: true
  end
end
