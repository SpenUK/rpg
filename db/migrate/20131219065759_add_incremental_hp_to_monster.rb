class AddIncrementalHpToMonster < ActiveRecord::Migration
  def change

  	add_column :monsters, :hp_per_level, :integer
  	add_column :monsters, :mp_per_level, :integer
  	add_column :monsters, :base_defense, :integer
  	add_column :monsters, :base_attack, :integer
  	add_column :monsters, :defense_per_level, :integer
  	add_column :monsters, :attack_per_level, :integer

  end
end
