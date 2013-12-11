class AddDamageRangeToAttack < ActiveRecord::Migration
  def change
  	add_column :attacks, :dmg_range, :integer
  end
end
