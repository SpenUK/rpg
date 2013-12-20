class CreateMobBattles < ActiveRecord::Migration
  def change
    create_table :mob_battles do |t|
      t.integer :challenger_id
      t.integer :defender_id
      t.string :status

      t.timestamps
    end
  end
end
