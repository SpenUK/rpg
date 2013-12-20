class RemodelBattlesAndBattleSessions < ActiveRecord::Migration
  def change

  	remove_column :battles, :challenger_type, :string
  	remove_column :battles, :defender_type, :string

  	rename_column :battle_sessions, :battle_id, :fight_id
  	add_column :battle_sessions, :fight_type, :string, default: "Battle"

  	add_column :battle_requests, :sender_type, :string, default: "Character"

  end
end
