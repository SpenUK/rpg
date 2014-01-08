class ItemsController < ApplicationController

	def show
		@item_ref = Item.find(params[:id])
		@item = @item_ref.build_item

		respond_to do |format|
       format.html do 
       	if request.xhr?
       		@light_box_layout = true
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
		@item_ref = Item.find(params[:item_id])
		@item = @item_ref.build_item

		if @item_ref.owner_type == "Vendor"
			@item_ref.owner_type = "Transaction"
			@item_ref.save

			if @character.gold >= @item.base_price

				@character.gold = @character.gold - @item.base_price
				@character.save

				@item_ref.owner_id = @character.id
				@item_ref.owner_type = "Character"

				@item_ref.save
				redirect_to :inventory, notice: "Purchased #{@item.name}!"
			else
				@item_ref.owner_type = "Vendor"
				@item_ref.save

				redirect_to vendor_path(@vendor.id), notice: "Looks like you can't afford #{@item.name}!"
			end
		else
			redirect_to vendor_path(@vendor.id), notice: "It looks like this item isn't for sale!"
		end
	end

	def destroy
		@item_ref = Item.find(params[:id])
		@item = @item_ref.build_item

		if @item_ref.owner == current_char
			@item_ref.destroy
			redirect_to :inventory, notice: "Discarded #{@item.name}!"
		else
			redirect_to :inventory, notice: "Whoops! You can't discard an item that's not yours!"
		end
	end

	def consume
		@item_ref = Item.find(params[:id])
		@item = @item_ref.build_item

		if battle_session
			redirect_to :inventory, alert: "Whoops! You can't use that while you have a battle in session!"
		elsif @item_ref.owner == current_char
			
			@character = Character.find(current_char.id)

			if @item_ref.subclass_type == "Consumable"
				@item = @item_ref.build_item

				full_hp = (@character.current_hp >= @character.max_hp)
				full_mp = (@character.current_mp >= @character.max_mp)

				change_to_hp = (!full_hp && @item.hp_regen > 0)
				change_to_mp = (!full_mp && @item.mp_regen > 0)

				if change_to_mp || change_to_hp
					@item_ref.destroy
						
					@mp_difference = @item.mp_regen
					if (@character.max_mp - @character.current_mp) < @mp_difference
						@mp_difference = (@character.max_mp - @character.current_mp)
					end

					@hp_difference = @item.hp_regen
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

	def equip

		@item = Item.find(params[:inventory_item])

		@slot = params[:target_slot]

		if @slot == 'consumable'
			@slot = "consumable#{params[:target_slot_id]}"
		end

		@char_id = current_char.id

		@item.equip_item(@slot)


		@item = params[:inventory_item]
		respond_to do |format|
       format.json { render json: {slot: @slot, item: @item, char: @char_id, type: params[:target_slot_id]}}
  	end
	end

end








