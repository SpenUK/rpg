class CreateHtbtmTableForBattlesAndUsers < ActiveRecord::Migration
  def change
    create_table :battles_users do |t|
    	t.integer :battle_id
      t.integer :user_id

    end
  end
end
