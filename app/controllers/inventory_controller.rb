class InventoryController < ApplicationController

	def index
		@splash = "inventory"

		@items = []

		current_char.items.each do |item|
			@items << item.build_item
		end




		# @item_ref = Item.find(params[:id])
		# @item = Item.build_item(@item_ref.subclass_id, @item_ref.subclass_type)
	end
end
