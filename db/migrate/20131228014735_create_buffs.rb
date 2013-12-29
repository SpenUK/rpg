class CreateBuffs < ActiveRecord::Migration
  def change
    create_table :buffs do |t|
      t.string :title
      t.integer :effect_reference
      t.integer :mp_consumption

      t.timestamps
    end
  end
end
