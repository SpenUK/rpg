class CreatePotions < ActiveRecord::Migration
  def change
    create_table :potions do |t|
      t.string :name
      t.string :description
      t.integer :mp_regen
      t.integer :hp_regen
      t.integer :base_price

      t.timestamps
    end

    add_column :items, :subclass_type, :string
  end
end
