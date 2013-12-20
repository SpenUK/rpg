class BattleSessionsController < ApplicationController

	def create
	end

	def destroy

		@battle_session = BattleSession.find(params[:id])


		if @battle_session.fight_type == "MobBattle"
			get_mob_rewards(MobBattle.find(@battle_session.fight_id))
		elsif @battle_session.fight_type == "Battle"
			get_rewards(Battle.find(@battle_session.fight_id))
		end


		@battle_session.destroy

		redirect_to :root
	end

	private

	def get_pvp_rewards(battle)


	end

	def get_mob_rewards(battle)

			@character = battle.defender
			@mob = battle.challenger
			@monster = @mob.species

			if battle.winner.first == @character

				@exp = @monster.base_exp + (@monster.exp_per_level * (@mob.level - 1))

				@gold = @mob.held_gold

				@updated_exp = @character.exp + @exp
				@updated_gold = @character.gold + @gold

				@character.update_attributes(gold: @updated_gold, exp: @updated_exp)

				extra_exp = level_up_check(@character.level, @character.exp)
					
				if extra_exp
					@character.update_attributes(level: (@character.level + 1), exp: extra_exp)
				end

			else
				@character.gold -= (@character.gold / 20).to_i
				@character.exp -= (@character.exp / 10).to_i
				@character.save
			end
	end

end











