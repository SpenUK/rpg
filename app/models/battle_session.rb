class BattleSession < ActiveRecord::Base

	belongs_to :challenger, class_name: "Character", foreign_key: 'challenger_id'
	belongs_to :defender, class_name: "Character", foreign_key: 'defender_id'
	belongs_to :fakebattle

end
