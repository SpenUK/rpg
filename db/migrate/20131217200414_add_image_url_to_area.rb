class AddImageUrlToArea < ActiveRecord::Migration
  def change

  	add_column :areas, :background_image, :string

  end
end
