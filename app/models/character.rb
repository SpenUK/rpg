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

  has_many :mob_battles

  has_and_belongs_to_many :attacks

  has_many :skills

  has_one :battle_session

  # --------------------------------------------------

    has_many :items, as: :owner

  # --------------------------------------------------

  #-------- Inventory ----------

    has_one :hat, class_name: "Item", foreign_key: "hat_id"
    has_one :top, class_name: "Item", foreign_key: "top_id"
    has_one :bottom, class_name: "Item", foreign_key: "bottom_id"
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
    (Item.find(1)).build_item
  end

  def top
    (Item.find(1)).build_item
  end

  def bottoms
    (Item.find(1)).build_item
  end

  def left_hand
    (Item.find(1)).build_item
  end

  def right_hand
    (Item.find(1)).build_item
  end

  def shoes
    (Item.find(1)).build_item
  end


  def held1
    (Item.find(1)).build_item
  end

  def held2
    (Item.find(1)).build_item
  end

  def held3
    (Item.find(1)).build_item
  end

  def held4
    (Item.find(1)).build_item
  end

  def held5
    (Item.find(1)).build_item
  end

  def held6
    (Item.find(1)).build_item
  end

  def held7
    (Item.find(1)).build_item
  end

  def held8
    (Item.find(1)).build_item
  end


  #------------------------------







end
