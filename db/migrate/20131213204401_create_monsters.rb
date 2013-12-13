class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.string :name
      t.integer :max_hp
      t.integer :max_mp
      t.integer :base_exp
      t.integer :exp_per_level
      t.integer :base_gold
      t.integer :gold_per_level

      t.timestamps
    end
  end
end
