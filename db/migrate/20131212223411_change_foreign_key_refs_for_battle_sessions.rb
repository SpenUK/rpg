class ChangeForeignKeyRefsForBattleSessions < ActiveRecord::Migration
  def change

  	remove_column :battle_sessions, :user_id
  	remove_column :battle_sessions, :opponent_id

  	add_column :battle_sessions, :challenger_id, :integer
  	add_column :battle_sessions, :defender_id, :integer

  end
end
