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

  has_one :battle_session

  # --------------------------------------------------

    has_many :items, as: :owner

  # --------------------------------------------------




  def all_battles
  	def_battles + off_battles
  end

  def exp_to_next_level

  end

end
