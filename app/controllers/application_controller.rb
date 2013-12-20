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
    Attack.create(title: 'struggle', melee: true, elemental: 'normal', physical: true, base_dmg: 2, dmg_range: 8, mp_consumption: 0 ) unless Attack.find_by(title: 'struggle')

    Attack.create(title: 'Bite', melee: true, elemental: 'normal', physical: true, base_dmg: 10, dmg_range: 6, mp_consumption: 0 ) unless Attack.find_by(title: 'Bite')
    Attack.create(title: 'Stomp', melee: true, elemental: 'normal', physical: true, base_dmg: 8, dmg_range: 8, mp_consumption: 0 ) unless Attack.find_by(title: 'Stomp')
    Attack.create(title: 'Slam', melee: true, elemental: 'normal', physical: true, base_dmg: 10, dmg_range: 10, mp_consumption: 20 ) unless Attack.find_by(title: 'Slam')

    Consumable.create(name: 'Green Apple', description: "A tasty Green Apple", hp_regen: 15, mp_regen: 0, base_price: 20, rarity: 200, image_url: "items/green_apple.png" ) unless Consumable.find_by(name: 'Green Apple')
    Consumable.create(name: 'Red Apple', description: "A tasty Red Apple", hp_regen: 25, mp_regen: 0, base_price: 40, rarity: 280, image_url: "items/red_apple.png" ) unless Consumable.find_by(name: 'Red Apple')
    Consumable.create(name: 'Old Cheese', description: "Eww, this cheese stinks!", hp_regen: 10, mp_regen: 10, base_price: 40, rarity: 320, image_url: "items/old_cheese.png" ) unless Consumable.find_by(name: 'Old Cheese')

    Armour.create(name: "Shiney Helmet", description: "ooOOoo shiney!", base_def: 10, def_range: 6) unless Armour.find_by(name: "Shiney Helmet")
    Weapon.create(name: "Tiny Sword", description: "its all about how you use it", base_price: 320, base_dmg: 10, dmg_range: 6) unless Weapon.find_by(name: "Tiny Sword")
    Weapon.create(name: "Steel Sword", description: "A sturdy Steel Sword, good for dicing carrots", base_price: 1120, base_dmg: 15, dmg_range: 10, image_url: "items/sword_2.png") unless Weapon.find_by(name: "Steel Sword")
    Weapon.create(name: "Carrot Sword", description: "Is it a sword? no. no it's a carrot.", base_price: 999999, base_dmg: 25, dmg_range: 40, image_url: "items/carrot_sword.png") unless Weapon.find_by(name: "Carrot Sword")
    Weapon.create(name: "Rusty Sword", description: "Old, useless and rusty", base_price: 120, base_dmg: 4, dmg_range: 3) unless Weapon.find_by(name: "Rusty Sword")
    Vendor.create(name: 'General Store', area_id: 1, owner_image: "owner_placeholder.png" ) unless Vendor.find_by(name: 'General Store')

    Inn.create(name: 'Home', area_id: 1, keeper_image: "owner_placeholder.png", greeting: "Home sweet home, why not take a nap?", hp_regen: 40, mp_regen: 0, cost: 0) unless Inn.find_by(name: 'Home')

    Area.create(name: 'HomeTown', description: "Surrounded by mountains lies your hometown, there's not a lot to do around here!", background_image: "hometown_background.png") unless Area.find_by(name: 'HomeTown')
      AreaObject.create(title: "Home", area_id: 1, x_position: 240, y_position: 410, image_url: "home.png", link_path: "inns/1") unless AreaObject.find_by(title: "Home")
      AreaObject.create(title: "General Store", area_id: 1, x_position: 450, y_position: 400, image_url: "shop_1.png", link_path: "vendors/1") unless AreaObject.find_by(title: "General Store")
      AreaObject.create(title: "Dark Woods", area_id: 1, x_position: 290, y_position: 200, image_url: "home.png", link_path: "hunt/1") unless AreaObject.find_by(title: "Dark Woods")

    Monster.create(name: "Bush Pig", max_hp: 50, max_mp: 0, base_exp: 20, exp_per_level: 10, base_gold: 40, gold_per_level: 10, hp_per_level: 20, mp_per_level: 20, base_attack: 20, attack_per_level: 10, base_defense: 25, defense_per_level: 10) unless Monster.find_by(name: "Bush Pig")
    Monster.create(name: "Small Spider", max_hp: 40, max_mp: 40, base_exp: 25, exp_per_level: 10, base_gold: 30, gold_per_level: 15, hp_per_level: 15, mp_per_level: 20, base_attack: 30, attack_per_level: 15, base_defense: 15, defense_per_level: 15) unless Monster.find_by(name: "Small Spider")

    # -----------------------------------------------------
    
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 2, subclass_type: "Weapon")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 1, subclass_type: "Consumable")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 1, subclass_type: "Consumable")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 2, subclass_type: "Consumable")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 3, subclass_type: "Consumable")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 2, subclass_type: "Consumable")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 3, subclass_type: "Consumable")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 4, subclass_type: "Weapon")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 1, subclass_type: "Consumable")


    # ------------------------------------------------------

  end


  private
  def not_authenticated
  	redirect_to login_path, alert: "Please login first"
	end

end
