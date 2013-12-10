class TransferMessagesFromUsersToCharacters < ActiveRecord::Migration
  def change

  	remove_column :messages, :user_id
  	add_column :messages, :target_id, :integer
  	
  end
end
