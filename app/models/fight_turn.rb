class FightTurn < ActiveRecord::Base

	belongs_to :fight, polymorphic: true
	belongs_to :maker, polymorphic: true
	belongs_to :target, polymorphic: true

end
