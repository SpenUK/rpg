class CreateCharacterConsumableJoin < ActiveRecord::Migration
  def change

    create_table :characters_consumables do |t|
      t.integer :character_id
      t.integer :consumable_id
    end

  end
end
