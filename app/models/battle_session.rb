class BattleSession < ActiveRecord::Base

	belongs_to :character
  belongs_to :fight, polymorphic: true

  # -----------------------

  # -----------------------

end
