class AddStatPointsToCharacter < ActiveRecord::Migration
  def change

  	add_column :characters, :stats_to_spend, :integer


  end
end
