class CreateMobs < ActiveRecord::Migration
  def change
    create_table :mobs do |t|
      t.string :species_type
      t.integer :species_id
      t.integer :level, default: 1
      t.integer :current_hp, default: 10
      t.integer :current_mp, default: 10

      t.timestamps
    end
  end
end
