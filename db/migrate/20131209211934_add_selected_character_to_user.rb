class AddSelectedCharacterToUser < ActiveRecord::Migration
  def change
  	add_column :users, :selected_character_id, :integer
  end
end
