class AddPathToAreaObjects < ActiveRecord::Migration
  def change
  	add_column :area_objects, :link_path, :string
  end
end
