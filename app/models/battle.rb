class Battle < ActiveRecord::Base

# -----------------------

  belongs_to :challenger, :class_name => 'Character', :foreign_key => 'challenger_id'
  belongs_to :defender, :class_name => 'Character', :foreign_key => 'defender_id'
  belongs_to :winner, :class_name => 'Character', :foreign_key => 'winner_id'
  has_one :battle_session

  has_many :turns, class_name: 'FightTurn', as: :fight
# -----------------------

	def winner
  	if self.challenger.current_hp == 0 && self.defender.current_hp == 0
  		self.winner_id = 0
      self.save
  	elsif self.challenger.current_hp == 0
  			self.winner_id = self.defender.id
        self.save
  	elsif self.defender.current_hp == 0
  			self.winner_id = self.challenger.id
        self.save
  	else
  		nil
  	end
  end

  def outcome
  	if winner_id == 0
  		"Tie!"
  	elsif winner_id == defender_id
  		"#{defender.name} Wins!"
    elsif winner_id == challenger_id
      "#{challenger.name} Wins!"
  	else
  		nil
  	end	
  end

  def update_status
      # determines who's turn it is next or if the battle is ended

      if self.challenger.current_hp <= 0 || self.defender.current_hp <= 0 
        self.status = "ended"
      elsif self.status == "begin"
        self.status = self.defender_id.to_s
      elsif self.status == self.defender_id.to_s
        self.status = self.challenger_id
      else
        self.status = self.defender_id
      end

      self.save
    end




end
