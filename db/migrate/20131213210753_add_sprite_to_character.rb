class AddSpriteToCharacter < ActiveRecord::Migration
  def change

  	add_column :characters, :sprite_url, :string
  end
end
