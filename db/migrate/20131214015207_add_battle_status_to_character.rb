class AddBattleStatusToCharacter < ActiveRecord::Migration
  def change

  	add_column :characters, :battle_status, :string

		add_column :battles, :winner_id, :integer  	

  end
end
