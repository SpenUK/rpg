class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login

  include ApplicationHelper

  # def current_char
  #   if current_user.selected_character_id
  # 	  Character.find(current_user.selected_character_id)
  #   else
  #     nil
  #   end
  # end

  def populate_db
    Attack.create(title: 'punch', melee: true, elemental: 'normal', physical: true, base_dmg: 6, dmg_range: 2, mp_consumption: 0 ) unless Attack.find_by(title: 'punch')
    Attack.create(title: 'kick', melee: true, elemental: 'normal', physical: true, base_dmg: 4, dmg_range: 6, mp_consumption: 0 ) unless Attack.find_by(title: 'kick')
    Attack.create(title: 'spark', melee: true, elemental: 'lightning', physical: true, base_dmg: 5, dmg_range: 15, mp_consumption: 0 ) unless Attack.find_by(title: 'spark')
    Attack.create(title: 'ember', melee: true, elemental: 'fire', physical: true, base_dmg: 8, dmg_range: 10, mp_consumption: 0 ) unless Attack.find_by(title: 'ember')
    Attack.create(title: 'poison', melee: true, elemental: 'poison', physical: true, base_dmg: 10, dmg_range: 6, mp_consumption: 0 ) unless Attack.find_by(title: 'poison')
    Attack.create(title: 'slash', melee: true, elemental: 'normal', physical: true, base_dmg: 12, dmg_range: 8, mp_consumption: 0 ) unless Attack.find_by(title: 'slash')
    Attack.create(title: 'power_slash', melee: true, elemental: 'normal', physical: true, base_dmg: 14, dmg_range: 12, mp_consumption: 10 ) unless Attack.find_by(title: 'power_slash')

    Consumable.create(title: 'Green Apple', description: "A tasty Green Apple", hp_regen: 15, mp_regen: 0, base_price: 20, rarity: 200, image_url: "items/green_apple.png" ) unless Consumable.find_by(title: 'Green Apple')
    Consumable.create(title: 'Red Apple', description: "A tasty Red Apple", hp_regen: 25, mp_regen: 0, base_price: 40, rarity: 280, image_url: "items/red_apple.png" ) unless Consumable.find_by(title: 'Red Apple')
    Consumable.create(title: 'Old Cheese', description: "Eww, this cheese stinks!", hp_regen: 10, mp_regen: 10, base_price: 40, rarity: 320, image_url: "items/old_cheese.png" ) unless Consumable.find_by(title: 'Old Cheese')

    Vendor.create(name: 'General Store', area_id: 1, owner_image: "items/old_cheese.png" ) unless Vendor.find_by(name: 'General Store')

    Inn.create(name: 'Home', area_id: 1, keeper_image: "items/old_cheese.png", greeting: "Home sweet home, why not take a nap?", hp_regen: 40, mp_regen: 0, cost: 0) unless Inn.find_by(name: 'Home')



  end


  private
  def not_authenticated
  	redirect_to login_path, alert: "Please login first"
	end

end
