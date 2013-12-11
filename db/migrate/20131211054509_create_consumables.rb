class CreateConsumables < ActiveRecord::Migration
  def change
    create_table :consumables do |t|
      t.string :title
      t.string :description
      t.integer :hp_regen
      t.integer :mp_regen
      t.integer :base_price
      t.integer :rarity

      t.timestamps
    end
  end
end
