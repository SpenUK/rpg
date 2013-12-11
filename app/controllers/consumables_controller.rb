class ConsumablesController < ApplicationController

	def add
		@consumable = Consumable.find(rand(Consumable.all.length+1))
		@current = Character.find(current_char.id)

		@current.consumables << @consumable

		redirect_to inventory_path
	end

	def consume
		@consumable = Consumable.find(params[:id])

		@current = Character.find(current_char.id)

		@current.consumables.delete(@consumable)

		redirect_to inventory_path, message: "#{@consumable.title} consumed"
	end

end
