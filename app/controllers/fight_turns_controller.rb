class FightTurnsController < ApplicationController

	belongs_to :maker, polymorphic: true
	belongs_to :target, polymorphic: true

end
