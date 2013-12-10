class ChangeUserIDsToCharIDsForBattleRequests < ActiveRecord::Migration
  def change

  	remove_column :battle_requests, :user_id
  	add_column :battle_requests, :sender_id, :integer
  	
  end
end
