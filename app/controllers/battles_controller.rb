class BattlesController < ApplicationController
	include ApplicationHelper

	def new
	end

	def show
		@battle = Battle.find(params[:id])

		@defender = Character.find(@battle.defender_id)
		@challenger = Character.find(@battle.challenger_id)


		current_char.id == @defender.id ? (@player1 = @defender; @player2 = @challenger) : (@player2 = @defender; @player1 = @challenger)
	end

	def create

		@battle_request = BattleRequest.find(params[:id])

		@number_of_battles = current_char.battles.length 

		if @number_of_battles >= 1
			redirect_to :root, notice: "You already have a battle in session" 
		else
			new_battle = Battle.create(challenger_id: @battle_request.sender_id , defender_id: @battle_request.target_id , status: @battle_request.target_id )
			@battle_request.destroy

			redirect_to battle_path(new_battle.id)
		end
	end

		def attack

			if battle_session.status == current_char.id.to_s
				@attack = Attack.find(params[:id])

				@target = Character.find(params[:ch])

				@current = Character.find(current_char.id)

				@battle = Battle.find(battle_session.id)

				@current.current_mp -= @attack.mp_consumption

	    	base_dmg = @attack.base_dmg
	    	dmg_range = @attack.dmg_range

	    	@critical = true if rand > 0.8
	    	@dmg = (base_dmg + rand(dmg_range))
	    	@dmg = (@dmg * 1.8).round if @critical

	    	@target.current_hp -= @dmg if @target.current_hp > 0

		    @target.current_hp = 0 if @target.current_hp < 0

	  	  @target.save
	  	  @current.save

	  	  change_battle_status(@battle)

	    	redirect_to battle_path(battle_session.id, cr: @critical, p: @target.id, d: 1, dmg: @dmg, att: @attack)
	    elsif battle_session.status == "ended"
	    	redirect_to :back, notice: "This battle has ended"
	    else
	    	redirect_to :back, notice: "It's not your turn yet"
	    end
    end

    def change_battle_status(battle)

    	if Character.find(battle.challenger_id).current_hp <= 0 || Character.find(battle.defender_id).current_hp <= 0 
    		battle.status = "ended"
    	elsif battle.status == "begin"
    		battle.status = battle.defender_id.to_s
    	elsif battle.status == battle.defender_id.to_s
    		battle.status = battle.challenger_id
    	else
    		battle.status = battle.defender_id
    	end

    	battle.save

    end

end
