class CreateFightTurns < ActiveRecord::Migration
  def change
    create_table :fight_turns do |t|
      t.integer :maker_id
      t.string :maker_type
      t.integer :target_id
      t.string :target_type
      t.integer :damage
      t.integer :healed
      t.string :skill_used
      t.integer :skill_id
      t.string :skill_type
      t.string :item_used
      t.integer :item_used_id
      t.string :item_used_type

      t.timestamps
    end
  end
end
