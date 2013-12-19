class NeatenningUp < ActiveRecord::Migration
  def change

		create_table "area_objects", force: true do |t|
	    t.string   "title" 
	    t.integer  "area_id"
	    t.integer  "x_position"
	    t.integer  "y_position"
	    t.string   "image_url"
	    t.string   "link_path"

	    t.timestamps
	  end

	  create_table "areas", force: true do |t|
	    t.string   "name"
	    t.string   "description"
	    t.string   "background_image"

	    t.timestamps
	  end

	  create_table "armours", force: true do |t|
	    t.string   "name"
	    t.string   "description"
	    t.integer  "base_def", default: 5 
	    t.integer  "def_range", default: 0
	    t.string   "type"
	    t.string   "image_url"
	    t.integer  "rarity", default: 99999

	    t.timestamps
	  end

	  create_table "attack_characters", force: true do |t|
	    t.integer  "attack_id"
	    t.integer  "character_id"
	    
	    t.timestamps
	  end

	  create_table "attacks", force: true do |t|
	    t.string   "title"
	    t.boolean  "melee"
	    t.boolean  "physical"
	    t.string   "elemental"
	    t.integer  "base_dmg", default: 5
	    t.integer  "mp_consumption", default: 0
	    t.integer  "dmg_range", default: 0

	    t.timestamps
	  end

	  create_table "attacks_characters", force: true do |t|
	    t.integer "attack_id"
	    t.integer "character_id"
	  end

	  create_table "battle_requests", force: true do |t|
	    t.integer  "target_id"
	    t.string   "message"
	    t.integer  "wager", default: 0
	    t.integer  "sender_id"

	    t.timestamps
	  end

	  create_table "battle_sessions", force: true do |t|
	    t.integer  "battle_id"
	    t.integer  "character_id"

	    t.timestamps
	  end

	  create_table "battles", force: true do |t|
	    t.datetime "timeout"
	    t.integer  "challenger_id"
	    t.string  "challenger_type"
	    t.integer  "defender_id"
	    t.string  "defender_type"
	    t.string   "status"
	    t.integer  "winner_id"

	    t.timestamps
	  end

	  create_table "battles_users", force: true do |t|
	    t.integer "battle_id"
	    t.integer "user_id"
	  end

	  create_table "characters", force: true do |t|
	    t.string   "name"
	    t.integer  "user_id"
	    t.integer  "exp", default: 0
	    t.integer  "max_hp", default: 100
	    t.integer  "max_mp", default: 50
	    t.integer  "current_hp", default: 100
	    t.integer  "current_mp", default: 50
	    t.integer  "level", default: 1
	    t.integer  "stat_strength", default: 5
	    t.integer  "stat_dex", default: 4
	    t.integer  "stat_luck", default: 4
	    t.integer  "stat_int", default: 4
	    t.string   "gender", default: 'male'
	    t.boolean  "selected", default: false
	    t.string   "battle_status"
	    t.integer  "gold", default: 100
	    t.integer  "last_location_id", default: 0

	    t.timestamps
	  end

	  create_table "characters_users", force: true do |t|
	    t.integer "selected_character_id"
	    t.integer "user_id"
	  end

	  create_table "consumables", force: true do |t|
	    t.string   "name"
	    t.string   "description", default: ""
	    t.integer  "hp_regen", default: 0
	    t.integer  "mp_regen", default: 0
	    t.integer  "base_price", default: 20
	    t.integer  "rarity", default: 99999
	    t.string   "image_url", default: "/items/placeholder.png"

	    t.timestamps
	  end

	  create_table "inns", force: true do |t|
	    t.string   "name"
	    t.integer  "cost", default: 1000
	    t.integer  "area_id"
	    t.integer  "hp_regen", default: 0
	    t.integer  "mp_regen", default: 0
	    t.string   "keeper_image", default: "owner_placeholder.png"
	    t.string   "greeting", default: "Hi! We have a room spare if you'd like to rest, for a price of cause"
	    
	    t.timestamps
	  end

	  create_table "items", force: true do |t|
	    t.integer  "subclass_id", default: 1
	    t.integer  "owner_id", default: 999
	    t.string   "owner_type", default: "Vendor"
	    t.string   "subclass_type", default: "Consumable"
	    
	    t.timestamps
	  end

	  create_table "messages", force: true do |t|
	    t.integer  "sender_id"
	    t.string   "title"
	    t.text     "body"
	    t.string   "message_type"
	    t.integer  "target_id"

	    t.timestamps
	  end

	  create_table "users", force: true do |t|
	    t.string   "email",                 null: false
	    t.string   "crypted_password"
	    t.string   "salt"
	    t.integer  "selected_character_id"

	    t.timestamps
	  end

	  create_table "vendors", force: true do |t|
	    t.string   "name"
	    t.integer  "area_id"
	    t.string   "owner_image", default: "owner_placeholder.png"

	    t.timestamps
	  end

	  create_table "weapons", force: true do |t|
	    t.string   "name"
	    t.string   "description"
	    t.integer  "base_dmg", default: 5
	    t.integer  "dmg_range", default: 0
	    t.integer  "base_price", default: 100
	    t.string   "image_url"
	    t.integer  "rarity", default: 99999

	    t.timestamps
	  end
	end
end
