class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.integer :whose_turn
      t.datetime :timeout

      t.timestamps
    end
  end
end
