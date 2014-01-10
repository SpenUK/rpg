class Character < ActiveRecord::Base

  validate :gender_check, on: :create
  validates :name, uniqueness: true
  validates :name, length: { in: 3..30 }, on: :create

  def gender_check
    if ['female', 'male'].include? :gender
      errors.add(:gender, "Please choose your character's gender.")
    end
  end

  def user_has_less_than_four
    if user.characters.length >= 4
      errors.add(:user, "You already have the maximum number of characters")
    end
  end

	belongs_to :user

	has_many :sent_battle_requests, :class_name => "BattleRequest", as: :sender
  has_many :received_battle_requests, :class_name => "BattleRequest", foreign_key: "target_id"

  has_many :sent_messages, :class_name => "Message", foreign_key: "sender_id"
  has_many :received_messages, :class_name => "Message", foreign_key: "target_id"

  has_many :sent_fight_turns, class_name: "FightTurn", as: :maker
  has_many :received_fight_turns, class_name: "FightTurn", as: :target

  has_many :off_battles, :class_name => "Battle", foreign_key: "challenger_id"
  has_many :def_battles, :class_name => "Battle", foreign_key: "defender_id"
  has_many :won_battles, :class_name => "Battle", foreign_key: "winner_id"

  has_many :mob_battles
  has_many :won_mob_battles, :class_name => "MobBattle", foreign_key: "winner_id" 


  has_and_belongs_to_many :attacks

  has_many :skills

  has_one :battle_session

  # --------------------------------------------------

    has_many :items, as: :owner

  # --------------------------------------------------

  #-------- Inventory ----------

    has_one :hat, class_name: "Item", foreign_key: "hat_id"
    has_one :top, class_name: "Item", foreign_key: "top_id"
    has_one :bottoms, class_name: "Item", foreign_key: "bottoms_id"
    has_one :left_hand, class_name: "Item", foreign_key: "left_hand_id"
    has_one :right_hand, class_name: "Item", foreign_key: "right_hand_id"
    has_one :shoes, class_name: "Item", foreign_key: "shoes_id"
    has_one :held1, class_name: "Item", foreign_key: "held1_id"
    has_one :held2, class_name: "Item", foreign_key: "held2_id"
    has_one :hat, class_name: "Item", foreign_key: "hat_id"
    has_one :weapon, class_name: "Item", foreign_key: "weapon_id"

  #--------------------------




  def all_battles
  	def_battles + off_battles
  end

  def exp_to_next_level

  end

  def total_physical_defense
    40
  end

  def total_physical_attack
    (stat_strength * 1) + (stat_dex * 0.2) + ( 12 )#weapon_attack 
  end

  def total_elemental_defense
    40 + (stat_int * 1)
  end

  def total_elemental_attack
    (stat_int * 1)
  end


  #------- inventory defs -------

  def hat
    hat_id ? (Item.find(hat_id)).build_item : nil
  end

  def top
    top_id ? (Item.find(top_id)).build_item : nil
  end

  def bottoms
    bottoms_id ? (Item.find(bottoms_id)).build_item : nil
  end

  def left_hand
    left_hand_id ? (Item.find(left_hand_id)).build_item : nil
  end

  def right_hand
    right_hand_id ? (Item.find(right_hand_id)).build_item : nil
  end

  def shoes
    shoes_id ? (Item.find(shoes_id)).build_item : nil
  end


  def held1
    held1_id ? (Item.find(held1_id)).build_item : nil
  end

  def held2
    held2_id ? (Item.find(held2_id)).build_item : nil
  end

  def held3
    held3_id ? (Item.find(held3_id)).build_item : nil
  end

  def held4
    held4_id ? (Item.find(held4_id)).build_item : nil
  end

  def held5
    held5_id ? (Item.find(held5_id)).build_item : nil
  end

  def held6
    held6_id ? (Item.find(held6_id)).build_item : nil
  end

  def held7
    held7_id ? (Item.find(held7_id)).build_item : nil
  end

  def held8
    held8_id ? (Item.find(held8_id)).build_item : nil
  end

  def equipped_item_ids
    [hat_id, top_id, bottoms_id, right_hand_id, left_hand_id, shoes_id, held1_id, held2_id, held3_id, held4_id, held5_id, held6_id, held7_id, held8_id ]
  end

  def equipped_consumable_ids
    [held1_id, held2_id, held3_id, held4_id, held5_id, held6_id, held7_id, held8_id ]
  end

  def equipped_consumables
    consumables = []
    equipped_consumable_ids.each do |id|
      consumables << Item.find(id) if id
    end
    return consumables
  end


  #------------------------------







end
