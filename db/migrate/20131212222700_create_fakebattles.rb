class CreateFakebattles < ActiveRecord::Migration
  def change
    create_table :fakebattles do |t|
      t.integer :challenger_id
      t.integer :defender_id
      t.integer :winner_id

      t.timestamps
    end
  end
end
