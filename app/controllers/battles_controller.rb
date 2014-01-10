class BattlesController < ApplicationController
	include ApplicationHelper
	include CharacterSkills



	def index

		if battle_session
			@battles = false
			@battle = battle_session.fight
		else
			@battle = false
			@battles = current_char.all_battles
		end
	end

	def show

		@battle = Battle.find(params[:id])

			@defender = Character.find(@battle.defender_id)
			@challenger = Character.find(@battle.challenger_id)
			@skills = current_char.skills
			@items = current_char.equipped_consumables

		current_char.id == @defender.id ? (@player1 = @defender; @player2 = @challenger) : (@player2 = @defender; @player1 = @challenger)
	end

	def create

		@battle_request = BattleRequest.find(params[:id])

			@challenger_id = @battle_request.sender_id
			@defender_id = @battle_request.target_id
		

			if (Character.find(@challenger_id).current_hp == 0) or (Character.find(@defender_id).current_hp == 0)
				redirect_to :root, notice: "Either your opponent or yourself is not ready to join a battle"
			elsif current_char.battle_session
				redirect_to :root, notice: "You already have a battle in session" 
			else
				new_battle = Battle.create(challenger_id: @challenger_id, defender_id: @defender_id, status: @defender_id )
				BattleSession.create(fight_id: new_battle.id, fight_type: "Battle", character_id: new_battle.challenger_id)
			 	BattleSession.create(fight_id: new_battle.id, fight_type: "Battle", character_id: new_battle.defender_id)
				@battle_request.destroy

				redirect_to battle_path(new_battle.id)
			end
	end

	def take_turn

		@battle = Battle.find(battle_session.fight.id)
		@skill_item = params[:skill_item]
		@skill_id = params[:skill_id]
		@item_id = params[:item_id]
		@style_id = params[:style_id]
		
		@skill = Skill.find(@skill_id) if @skill_id != ''
		read_time = 800

		# checks that it is the current users turn.
		if @battle.status == current_char.id.to_s
			# determines user choice between item or skill
			if @skill_id == '' && @item_id == ''
				error = "You didn't make a choice"
				# processes item if item was selected, otherwise use skill
			elsif @skill_item == 'item' && @item_id != ''
				# process item
				error = "You can't use this item, because items don't even work yet, you can equip them, look at them but not use them... bit silly really."
				read_time = 1800

			elsif @skill_id != '' && @skill.character_id.to_s == current_char.id.to_s
				# process skill
					@attack = @skill.process_skill(@style_id)
					@battle.winner

				if @attack == "NotEnoughMP"
					error = "You don't have enough MP!"
				else
	  	  	@battle.update_status
  	  	end

  	  else
  	  	error = "There was a problem! Check that you've selected a skill or an item."
  			read_time = 1100
  		end

		elsif @battle.status == "ended"
	    error = "This fight has ended!"
		else
			error = "It's not your turn yet!"
		end
		

		respond_to do |format|
       format.json { render json: { error_msg: error, error_delay: read_time, style: @style_id, damage: @attack.inspect.to_s } }
  	end

	end

		def attack # rename?

			if battle_session.fight.status == current_char.id.to_s #checks that it is the current users turn.

				@skill = Skill.find(params[:id])
				# should accept agression level and adjust attack outcomes, ignoring for item use and other skill types

						@battle = Battle.find(battle_session.fight.id)
						@target = Character.find(params[:ch])
						@current = Character.find(current_char.id)

						if @target.id != @battle.defender_id && @target.id != @battle.challenger_id
							redirect_to :back, notice: "Nice try! but you can't target this character!"
						else
							@attack = Skill.process_skill( @skill.skill_id, @skill.level, @current, @target, battle_session.fight.id, battle_session.fight_type)

							if @attack == "NotEnoughMP"
								redirect_to battle_path(@battle.id), notice: "Not enough MP"
							else
			  	  	change_battle_status(@battle)

			  	  	redirect_to battle_path(@battle.id)
			  	  	end
			  		end
	    	
	    elsif battle_session.fight.status == "ended"
	    	redirect_to :back, notice: "This battle has ended"
	    else
	    	redirect_to :back, notice: "It's not your turn yet" 
	    end
    end

    def use_item

    	if battle_session.fight.status == current_char.id.to_s #checks that it is the current users turn.

				@item = Item.find(params[:id])
				# should accept agression level and adjust attack outcomes, ignoring for item use and other skill types

						@battle = Battle.find(battle_session.fight.id)
						@target = Character.find(params[:ch])
						@current = Character.find(current_char.id)

						if @target.id != @battle.defender_id && @target.id != @battle.challenger_id
							redirect_to :back, notice: "Nice try! but this character is not part of this battle!"
						else
							@attack = Item.process_item( @item.id, @current, @target, battle_session.fight.id)

							if @attack == "NotEnoughMP"
								redirect_to battle_path(@battle.id), notice: "Not enough MP"
							else
			  	  	# change_battle_status(@battle)

			  	  	redirect_to battle_path(@battle.id)
			  	  	end
			  		end
	    	
	    elsif battle_session.fight.status == "ended"
	    	redirect_to :back, notice: "This battle has ended"
	    else
	    	redirect_to :back, notice: "It's not your turn yet" 
	    end

    end

end
