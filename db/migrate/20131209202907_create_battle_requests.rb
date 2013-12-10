class CreateBattleRequests < ActiveRecord::Migration
  def change
    create_table :battle_requests do |t|
      t.integer :user_id
      t.integer :target_id
      t.string :message
      t.integer :wager

      t.timestamps
    end
  end
end
