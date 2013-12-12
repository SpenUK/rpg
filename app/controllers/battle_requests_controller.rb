class BattleRequestsController < ApplicationController
	# include current_char

	def new
		@battle_request = BattleRequest.new

		@current = current_user.selected_character
		@target = Character.find(params[:id])

	end

	def create
		@current = current_user.selected_character
		@target = @target


		@battle_request = BattleRequest.new(battle_request_params)
		@battle_request[:sender_id] =  @current.id
		

		if @battle_request.save
			redirect_to :root, message: "Request sent"
		else
			redirect_to :root, message: "Request failed"
		end
	end

	def show
		@battle_request = BattleRequest.find(params[:id])
	end

	def decline
		@battle_request = BattleRequest.find(params[:id])

		@battle_request.destroy

		# redirect_to :controller=>'messages', :action=>'create', body: "#{current_char} declined your request", recipient: @battle_request.sender_id

		redirect_to :root, message: "Request declined"
	end


	private
	def battle_request_params
		params.require(:battle_request).permit(:wager, :message, :target_id)
	end
end
