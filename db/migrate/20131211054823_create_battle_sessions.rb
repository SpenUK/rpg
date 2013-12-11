class CreateBattleSessions < ActiveRecord::Migration
  def change
    create_table :battle_sessions do |t|
      t.integer :user_id
      t.integer :opponent_id

      t.timestamps
    end
  end
end
