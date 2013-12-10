class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :user_id
      t.integer :exp
      t.integer :max_hp
      t.integer :max_mp
      t.integer :current_hp
      t.integer :current_mp
      t.integer :level
      t.integer :stat_strength
      t.integer :stat_dex
      t.integer :stat_luck
      t.integer :stat_int
      t.string :gender

      t.timestamps
    end
  end
end
