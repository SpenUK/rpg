class VendorsController < ApplicationController

	def show
		@splash = "store"
		@vendor = Vendor.find(params[:id])
		if @vendor.area_id == current_location

			@items = []
			@vendor.items.each do |item|
				@items << item.build_item
			end
			
		else
			redirect_to explore_path, alert: "It looks like this store is not accessable from your current location!"	
		end
	end

end
