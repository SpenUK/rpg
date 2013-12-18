# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131218040353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "area_objects", force: true do |t|
    t.string   "title"
    t.integer  "area_id"
    t.integer  "x_position"
    t.integer  "y_position"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link_path"
  end

  create_table "areas", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_image"
  end

  create_table "armours", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "base_def"
    t.integer  "def_range"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "image_url"
    t.integer  "rarity"
  end

  create_table "attack_characters", force: true do |t|
    t.integer  "attack_id"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attacks", force: true do |t|
    t.string   "title"
    t.boolean  "melee"
    t.boolean  "physical"
    t.string   "elemental"
    t.integer  "base_dmg"
    t.integer  "mp_consumption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dmg_range"
  end

  create_table "attacks_characters", force: true do |t|
    t.integer "attack_id"
    t.integer "character_id"
  end

  create_table "battle_requests", force: true do |t|
    t.integer  "target_id"
    t.string   "message"
    t.integer  "wager"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sender_id"
  end

  create_table "battle_sessions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "battle_id"
    t.integer  "character_id"
  end

  create_table "battles", force: true do |t|
    t.datetime "timeout"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "challenger_id"
    t.integer  "defender_id"
    t.string   "status"
    t.integer  "winner_id"
  end

  create_table "battles_users", force: true do |t|
    t.integer "battle_id"
    t.integer "user_id"
  end

  create_table "characters", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "exp"
    t.integer  "max_hp"
    t.integer  "max_mp"
    t.integer  "current_hp"
    t.integer  "current_mp"
    t.integer  "level"
    t.integer  "stat_strength"
    t.integer  "stat_dex"
    t.integer  "stat_luck"
    t.integer  "stat_int"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "selected"
    t.string   "battle_status"
    t.integer  "gold"
    t.integer  "last_location_id"
  end

  create_table "characters_consumables", force: true do |t|
    t.integer "character_id"
    t.integer "consumable_id"
  end

  create_table "characters_users", force: true do |t|
    t.integer "selected_character_id"
    t.integer "user_id"
  end

  create_table "consumables", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "hp_regen"
    t.integer  "mp_regen"
    t.integer  "base_price"
    t.integer  "rarity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url"
  end

  create_table "consumables_vendors", force: true do |t|
    t.integer "consumable_id"
    t.integer "vendor_id"
  end

  create_table "fakebattles", force: true do |t|
    t.integer  "challenger_id"
    t.integer  "defender_id"
    t.integer  "winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inns", force: true do |t|
    t.string   "name"
    t.integer  "cost"
    t.integer  "area_id"
    t.integer  "hp_regen"
    t.integer  "mp_regen"
    t.string   "keeper_image"
    t.string   "greeting"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_instances", force: true do |t|
    t.string   "category"
    t.integer  "item_id"
    t.integer  "owner_id"
    t.integer  "owner_type"
    t.integer  "condition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.integer  "subclass_id"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subclass_type"
    t.string   "type"
  end

  create_table "joins_for_monsters_areas_and_items", force: true do |t|
  end

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.string   "title"
    t.text     "body"
    t.string   "message_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "target_id"
  end

  create_table "monsters", force: true do |t|
    t.string   "name"
    t.integer  "max_hp"
    t.integer  "max_mp"
    t.integer  "base_exp"
    t.integer  "exp_per_level"
    t.integer  "base_gold"
    t.integer  "gold_per_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "potions", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "mp_regen"
    t.integer  "hp_regen"
    t.integer  "base_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "image_url"
    t.integer  "rarity"
  end

  create_table "users", force: true do |t|
    t.string   "email",                 null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "selected_character_id"
  end

  create_table "vendors", force: true do |t|
    t.string   "name"
    t.integer  "area_id"
    t.string   "owner_image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weapons", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "base_dmg"
    t.integer  "dmg_range"
    t.integer  "base_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "image_url"
    t.integer  "rarity"
  end

end
