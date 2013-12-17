class AddGoldAndLastLocationToCharacter < ActiveRecord::Migration
  def change

  	add_column :characters, :gold, :integer
  	add_column :characters, :last_location_id, :integer
  end
end
