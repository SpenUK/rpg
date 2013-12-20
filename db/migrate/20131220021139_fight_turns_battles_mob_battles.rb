class FightTurnsBattlesMobBattles < ActiveRecord::Migration
  def change

  	add_column :fight_turns, :fight_id, :integer
  	add_column :fight_turns, :fight_type, :string
  	add_column :fight_turns, :critical, :boolean

  end
end
