class AddSummaryToFightTurns < ActiveRecord::Migration
  def change


  	add_column :fight_turns, :serialized_object, :text

  	remove_column :fight_turns, :damage, :integer
  	remove_column :fight_turns, :healed, :integer
  	remove_column :fight_turns, :skill_used, :string
  	remove_column :fight_turns, :skill_id, :integer
  	remove_column :fight_turns, :skill_type, :string
  	remove_column :fight_turns, :item_used, :string
  	remove_column :fight_turns, :item_used_id, :integer
  	remove_column :fight_turns, :item_used_type, :string
  	remove_column :fight_turns, :critical, :boolean

  end
end
