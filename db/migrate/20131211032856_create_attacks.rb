class CreateAttacks < ActiveRecord::Migration
  def change
    create_table :attacks do |t|
      t.string :title
      t.boolean :melee
      t.boolean :physical
      t.string :elemental
      t.integer :base_dmg
      t.integer :dmg_range
      t.integer :mp_consumption

      t.timestamps
    end
  end
end
