class VendorsController < ApplicationController

	def show

		@vendor = Vendor.find(params[:id])
		if @vendor.area_id == current_location
			
		else
			redirect_to explore_path, alert: "It looks like this store is not accessable from your current location!"	
		end
		
		

	end

end
