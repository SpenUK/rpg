class Battle < ActiveRecord::Base

# -----------------------
	# has_many :comments
  # has_many :moves
  belongs_to :challenger, :class_name => 'Character', :foreign_key => 'challenger_id'
  belongs_to :defender, :class_name => 'Character', :foreign_key => 'defender_id'
  has_one :battle_session
# -----------------------

	def winner
  	if challenger.current_hp == 0 && defender.current_hp == 0
  		[challenger, defender]
  	elsif challenger.current_hp == 0
  			[defender]
  	elsif defender.current_hp == 0
  			[challenger]
  	else
  		nil
  	end
  end

  def outcome
  	if winner.length > 1
  		"Tie!"
  	elsif winner.length == 1
  		"#{winner.first.name} Wins!"
  	else
  		nil
  	end	
  end

end
