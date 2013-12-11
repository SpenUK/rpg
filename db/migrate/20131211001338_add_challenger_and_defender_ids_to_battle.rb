class AddChallengerAndDefenderIdsToBattle < ActiveRecord::Migration
  def change

  	add_column :battles, :challenger_id, :integer
  	add_column :battles, :defender_id, :integer

  	add_column :battles, :status, :string
  	remove_column :battles, :whose_turn

  end
end
