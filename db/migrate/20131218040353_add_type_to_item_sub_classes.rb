class AddTypeToItemSubClasses < ActiveRecord::Migration
  def change

  	add_column :items, :type, :string

  	add_column :potions, :type, :string
  	add_column :armours, :type, :string
  	add_column :weapons, :type, :string


  	add_column :potions, :image_url, :string
  	add_column :armours, :image_url, :string
  	add_column :weapons, :image_url, :string

  	add_column :potions, :rarity, :integer
  	add_column :armours, :rarity, :integer
  	add_column :weapons, :rarity, :integer

  	rename_column :consumables, :title, :name 	

  end
end
