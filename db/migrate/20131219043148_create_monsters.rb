class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.string :name
      t.integer :max_hp, default: 10000
      t.integer :max_mp, default: 10000
      t.integer :base_exp, default: 10
      t.integer :exp_per_level, default: 2
      t.integer :base_gold, default: 10
      t.integer :gold_per_level, default: 2

      t.timestamps
    end
  end
end
