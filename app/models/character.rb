class Character < ActiveRecord::Base

	belongs_to :user

	has_many :sent_battle_requests, :class_name => "BattleRequest", foreign_key: "sender_id"
  has_many :received_battle_requests, :class_name => "BattleRequest", foreign_key: "target_id"
end
