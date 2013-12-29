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

ActiveRecord::Schema.define(version: 20131229065200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "area_objects", force: true do |t|
    t.string   "name"
    t.integer  "area_id"
    t.integer  "x_position"
    t.integer  "y_position"
    t.string   "image_url"
    t.string   "link_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "background_image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "armours", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "base_def",    default: 5
    t.integer  "def_range",   default: 0
    t.string   "type"
    t.string   "image_url"
    t.integer  "rarity",      default: 99999
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attack_characters", force: true do |t|
    t.integer  "attack_id"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attacks", force: true do |t|
    t.string   "name"
    t.boolean  "melee"
    t.boolean  "physical"
    t.string   "elemental"
    t.integer  "base_dmg",       default: 5
    t.integer  "mp_consumption", default: 0
    t.integer  "dmg_range",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attacks_characters", force: true do |t|
    t.integer "attack_id"
    t.integer "character_id"
  end

  create_table "attacks_monsters", force: true do |t|
    t.integer "attack_id"
    t.integer "monster_id"
  end

  create_table "battle_requests", force: true do |t|
    t.integer  "target_id"
    t.string   "message"
    t.integer  "wager",       default: 0
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sender_type", default: "Character"
  end

  create_table "battle_sessions", force: true do |t|
    t.integer  "fight_id"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fight_type",   default: "Battle"
  end

  create_table "battles", force: true do |t|
    t.datetime "timeout"
    t.integer  "challenger_id"
    t.integer  "defender_id"
    t.string   "status"
    t.integer  "winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "battles_users", force: true do |t|
    t.integer "battle_id"
    t.integer "user_id"
  end

  create_table "buffs", force: true do |t|
    t.string   "title"
    t.integer  "effect_reference"
    t.integer  "mp_consumption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characters", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "exp",              default: 0
    t.integer  "max_hp",           default: 100
    t.integer  "max_mp",           default: 50
    t.integer  "current_hp",       default: 100
    t.integer  "current_mp",       default: 50
    t.integer  "level",            default: 1
    t.integer  "stat_strength",    default: 5
    t.integer  "stat_dex",         default: 4
    t.integer  "stat_luck",        default: 4
    t.integer  "stat_int",         default: 4
    t.string   "gender",           default: "male"
    t.boolean  "selected",         default: false
    t.string   "battle_status"
    t.integer  "gold",             default: 100
    t.integer  "last_location_id", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_url"
    t.integer  "stats_to_spend"
  end

  create_table "characters_users", force: true do |t|
    t.integer "selected_character_id"
    t.integer "user_id"
  end

  create_table "consumables", force: true do |t|
    t.string   "name"
    t.string   "description", default: ""
    t.integer  "hp_regen",    default: 0
    t.integer  "mp_regen",    default: 0
    t.integer  "base_price",  default: 20
    t.integer  "rarity",      default: 99999
    t.string   "image_url",   default: "/items/placeholder.png"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "fakebattles", force: true do |t|
    t.integer  "challenger_id"
    t.integer  "defender_id"
    t.integer  "winner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fight_turns", force: true do |t|
    t.integer  "maker_id"
    t.string   "maker_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "damage"
    t.integer  "healed"
    t.string   "skill_used"
    t.integer  "skill_id"
    t.string   "skill_type"
    t.string   "item_used"
    t.integer  "item_used_id"
    t.string   "item_used_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fight_id"
    t.string   "fight_type"
    t.boolean  "critical"
  end

  create_table "inns", force: true do |t|
    t.string   "name"
    t.integer  "cost",         default: 1000
    t.integer  "area_id"
    t.integer  "hp_regen",     default: 0
    t.integer  "mp_regen",     default: 0
    t.string   "keeper_image", default: "owner_placeholder.png"
    t.string   "greeting",     default: "Hi! We have a room spare if you''d like to rest, for a price of cause"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.integer  "subclass_id",   default: 1
    t.integer  "owner_id",      default: 999
    t.string   "owner_type",    default: "Vendor"
    t.string   "subclass_type", default: "Consumable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "joins_for_monsters_areas_and_items", force: true do |t|
  end

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.string   "title"
    t.text     "body"
    t.string   "message_type"
    t.integer  "target_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mob_battles", force: true do |t|
    t.integer  "challenger_id"
    t.integer  "defender_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mobs", force: true do |t|
    t.string   "species_type"
    t.integer  "species_id"
    t.integer  "level",        default: 1
    t.integer  "current_hp",   default: 10
    t.integer  "current_mp",   default: 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "held_gold"
    t.integer  "max_hp"
    t.integer  "max_mp"
  end

  create_table "monsters", force: true do |t|
    t.string   "name"
    t.integer  "max_hp",            default: 10000
    t.integer  "max_mp",            default: 10000
    t.integer  "base_exp",          default: 10
    t.integer  "exp_per_level",     default: 2
    t.integer  "base_gold",         default: 10
    t.integer  "gold_per_level",    default: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hp_per_level"
    t.integer  "mp_per_level"
    t.integer  "base_defense"
    t.integer  "base_attack"
    t.integer  "defense_per_level"
    t.integer  "attack_per_level"
    t.string   "avatar_url"
  end

  create_table "skills", force: true do |t|
    t.integer  "character_id"
    t.integer  "skill_id"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                 null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.integer  "selected_character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", force: true do |t|
    t.string   "name"
    t.integer  "area_id"
    t.string   "owner_image", default: "owner_placeholder.png"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weapons", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "base_dmg",    default: 5
    t.integer  "dmg_range",   default: 0
    t.integer  "base_price",  default: 100
    t.string   "image_url"
    t.integer  "rarity",      default: 99999
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

end
