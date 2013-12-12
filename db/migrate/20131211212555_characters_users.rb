class CharactersUsers < ActiveRecord::Migration
  def change

  	create_table :characters_users do |t|
      t.integer :selected_character_id
      t.integer :user_id
    end


  end
end
