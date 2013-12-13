class AddBattleIdToBattleSession < ActiveRecord::Migration
  def change
  	add_column :battle_sessions, :battle_id, :integer
  end
end
