class CreateAreaObjects < ActiveRecord::Migration
  def change
    create_table :area_objects do |t|
      t.string :title
      t.integer :area_id
      t.integer :x_position
      t.integer :y_position
      t.string :image_url

      t.timestamps
    end
  end
end
