class AreasController < ApplicationController

	def index
		if current_location == 0
			@area = Area.find(1)
			@splash = "world"
		elsif current_location > 0
			@area = Area.find(current_location)
		else
			redirect_to :root, alert: "Could not find your location"
		end
		
	end


end
