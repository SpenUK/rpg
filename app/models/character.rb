class Character < ActiveRecord::Base

 # validates_inclusion_of :gender, :in => ['male', 'female'], 


  validate :gender_check, on: :create

  def gender_check
    if :gender != 'female' || 'male'
      errors.add(:gender, "Please choose your character's gender.")
    end
  end

	belongs_to :user

	has_many :sent_battle_requests, :class_name => "BattleRequest", foreign_key: "sender_id"
  has_many :received_battle_requests, :class_name => "BattleRequest", foreign_key: "target_id"

  has_many :sent_messages, :class_name => "Message", foreign_key: "sender_id"
  has_many :received_messages, :class_name => "Message", foreign_key: "target_id"

  has_many :off_battles, :class_name => "Battle", foreign_key: "challenger_id"
  has_many :def_battles, :class_name => "Battle", foreign_key: "defender_id"

  has_and_belongs_to_many :attacks
  has_and_belongs_to_many :consumables

  has_one :battle_session

  # ----------------------- 
    # has_many :battles #Keys > challenger, defender
    # has_many :battle_comments
    # has_many :moves
  # -----------------------




  def all_battles
  	def_battles + off_battles
  end

end
