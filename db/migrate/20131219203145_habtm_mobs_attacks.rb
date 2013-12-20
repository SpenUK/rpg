class HabtmMobsAttacks < ActiveRecord::Migration
  def change

  	create_table "attacks_monsters", force: true do |t|
	    t.integer "attack_id"
	    t.integer "monster_id"
	  end

  end
end
