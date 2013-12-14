class EditBattleSessionsAgain < ActiveRecord::Migration
  def change

  	remove_column :battle_sessions, :user_id
  	add_column :battle_sessions, :character_id, :integer

  end
end
