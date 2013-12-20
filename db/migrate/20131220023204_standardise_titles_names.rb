class StandardiseTitlesNames < ActiveRecord::Migration
  def change

  	rename_column :area_objects, :title, :name
  	rename_column :attacks, :title, :name


  end
end
