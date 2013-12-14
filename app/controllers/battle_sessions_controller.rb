class BattleSessionsController < ApplicationController

	def create
	end

	def destroy
		@battle_session = BattleSession.find(params[:id])

		@battle_session.destroy

		redirect_to :root
	end

end
