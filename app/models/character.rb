class Character < ActiveRecord::Base

	# validates :off_battles, :less_than_or_equal_to 1

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
  has_many :fakebattles

  def battles
  	def_battles + off_battles
  end

end
