class AttacksAndCharacters < ActiveRecord::Migration
  def change

  	create_table :attacks_characters do |t|
      t.integer :attack_id
      t.integer :character_id
    end

  end
end
