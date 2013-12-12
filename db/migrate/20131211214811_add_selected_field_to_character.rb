class AddSelectedFieldToCharacter < ActiveRecord::Migration
  def change
  	add_column :characters, :selected, :boolean
  end
end
