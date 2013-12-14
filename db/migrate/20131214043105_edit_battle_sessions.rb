class EditBattleSessions < ActiveRecord::Migration
  def change

  	remove_column :battle_sessions, :opponent_id
  	add_column :battle_sessions, :battle_id, :integer

  end
end
