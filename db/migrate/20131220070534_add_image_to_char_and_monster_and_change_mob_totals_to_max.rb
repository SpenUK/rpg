class AddImageToCharAndMonsterAndChangeMobTotalsToMax < ActiveRecord::Migration
  def change

  	rename_column :mobs, :total_hp, :max_hp
  	rename_column :mobs, :total_mp, :max_mp

  	add_column :characters, :avatar_url, :string
  	add_column :monsters, :avatar_url, :string
    
  end
end
