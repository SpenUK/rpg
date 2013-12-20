class AddCurrentMpAndHpAndHeldGoldToMob < ActiveRecord::Migration
  def change

  	add_column :mobs, :held_gold, :integer
  	add_column :mobs, :total_hp, :integer
  	add_column :mobs, :total_mp, :integer
  end
end
