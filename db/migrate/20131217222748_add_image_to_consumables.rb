class AddImageToConsumables < ActiveRecord::Migration
  def change
  	add_column :consumables, :image_url, :string
  end
end
