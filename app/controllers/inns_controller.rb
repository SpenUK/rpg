class InnsController < ApplicationController

	def show

		@inn = Inn.find(params[:id])
		if @inn.area_id == current_location
			
		else
			redirect_to explore_path, alert: "It looks like this inn is not accessable from your current location!"	
		end

	end

	def sleep

		@inn = Inn.find(params[:id])
		@character = Character.find(current_char.id)

		if @inn.area_id == current_location
			
			if battle_session
			redirect_to inn_path(@inn.id), alert: "Whoops! You can't sleep while in a battle"

			elsif @character.gold >= @inn.cost

				@character.current_hp += @inn.hp_regen
				@character.current_mp += @inn.hp_regen

				if @character.current_hp > @character.max_hp;  @character.current_hp = @character.max_hp end
				if @character.current_mp > @character.max_mp;  @character.current_mp = @character.max_mp end

				@character.gold -= @inn.cost

				@character.save

				redirect_to inn_path(@inn.id), notice: "Your feeling much better after some rest!"
			else
				redirect_to inn_path(@inn.id), alert: "It looks like this inn is not accessable from your current location!"	
			end

		else
			redirect_to explore_path, alert: "It looks like this inn is not accessable from your current location!"	
		end
	end


end
