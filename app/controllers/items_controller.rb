class ItemsController < ApplicationController

	def show
		@item_ref = Item.find(params[:id])
		@item = @item_ref.subclass

		respond_to do |format|
       format.html do 
       	if request.xhr?
	       	render :layout => false
	      end
       end
       format.json { render :layout => false }
       format.js { }
  	end
	end

	def purchase

		@character = Character.find(current_char.id)
		
		@vendor = Vendor.find(params[:vendor_id])
		@item = Item.find(params[:item_id])

		if @item.owner_type == "Vendor"
			@item.owner_type = "Transaction"
			@item.save

			if @character.gold >= @item.subclass.base_price

				@character.gold = @character.gold - @item.subclass.base_price
				@character.save

				@item.owner_id = @character.id
				@item.owner_type = "Character"

				@item.save
				redirect_to :inventory, notice: "Purchased #{@item.subclass.name}!"
			else
				@item.owner_type = "Vendor"
				@item.save

				redirect_to vendor_path(@vendor.id), notice: "Looks like you can't afford #{@item.subclass.name}!"
			end
		else
			redirect_to vendor_path(@vendor.id), notice: "It looks like this item isn't for sale!"
		end
	end

	def destroy
		@item = Item.find(params[:id])

		if @item.owner == current_char
			@item.destroy
			redirect_to :inventory, notice: "Discarded #{@item.subclass.name}!"
		else
			redirect_to :inventory, notice: "Whoops! You can't discard an item that's not yours!"
		end
	end

	def consume
		@item = Item.find(params[:id])

		if battle_session
			redirect_to :inventory, alert: "Whoops! You can't use that while you have a battle in session!"
		elsif @item.owner == current_char
			
			@character = Character.find(current_char.id)

			if @item.subclass_type == "Consumable"
				@consumable = @item.subclass

				full_hp = (@character.current_hp >= @character.max_hp)
				full_mp = (@character.current_mp >= @character.max_mp)

				change_to_hp = (!full_hp && @consumable.hp_regen > 0)
				change_to_mp = (!full_mp && @consumable.mp_regen > 0)

				if change_to_mp || change_to_hp
					@item.destroy
						
					@mp_difference = @consumable.mp_regen
					if (@character.max_mp - @character.current_mp) < @mp_difference
						@mp_difference = (@character.max_mp - @character.current_mp)
					end

					@hp_difference = @consumable.hp_regen
					if (@character.max_hp - @character.current_hp) < @hp_difference
						@hp_difference = (@character.max_hp - @character.current_hp)
					end


						@character.current_mp += @mp_difference
						@character.current_hp += @hp_difference

						@character.save

						hp_message = "#{@hp_difference} HP"
						mp_message = "#{@mp_difference} MP"

						@message = "Restored "+ "#{(hp_message if @hp_difference > 0)} "+
											"#{'and ' if (@hp_difference > 0 && @mp_difference > 0)}"+ 
											"#{(mp_message if @mp_difference > 0)}."


				else
					@message = "This item will have no effect!"
				end

			else
				@message = "You can't consume that item!"
			end

			redirect_to :inventory, notice: @message
		else
			redirect_to :inventory, alert: "Whoops! You can't use an item that's not yours!"
		end

	end

end








