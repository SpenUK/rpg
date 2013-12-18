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

		if current_location != @area.id
			@current = Character.find(current_char.id)
			@current.last_location_id = @area.id
			@current.save
		end
		
	end


end
