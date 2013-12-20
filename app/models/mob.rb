class Mob < ActiveRecord::Base

	belongs_to :species, polymorphic: true

	has_many :sent_fight_turns, class_name: "FightTurn", as: :maker
	has_many :received_fight_turns, class_name: "FightTurn", as: :target

end
