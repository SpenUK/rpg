class InnsController < ApplicationController

	def show

		@inn = Inn.find(params[:id])
		if @inn.area_id == current_location
			
		else
			redirect_to explore_path, alert: "It looks like this inn is not accessable from your current location!"	
		end
		
		

	end


end
