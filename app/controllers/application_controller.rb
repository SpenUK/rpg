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

    Inn.create(name: 'Home', area_id: 1, keeper_image: "owner_placeholder.png", greeting: "Home sweet home, why not take a nap?", hp_regen: 40, mp_regen: 0, cost: 0) unless Inn.find_by(name: 'Home')

    Area.create(name: 'HomeTown', description: "Surrounded by mountains lies your hometown, there's not a lot to do around here!", background_image: "hometown_background.png") unless Area.find_by(name: 'HomeTown')
      AreaObject.create(title: "Home", area_id: 1, x_position: 240, y_position: 410, image_url: "home.png", link_path: "inns/1") unless AreaObject.find_by(title: "Home")
      AreaObject.create(title: "General Store", area_id: 1, x_position: 450, y_position: 400, image_url: "shop_1.png", link_path: "vendors/1") unless AreaObject.find_by(title: "General Store")
      AreaObject.create(title: "Dark Woods", area_id: 1, x_position: 290, y_position: 200, image_url: "home.png", link_path: "hunt/1") unless AreaObject.find_by(title: "Dark Woods")

    Monster.create(name: "Brown Hog", max_hp: 50, max_mp: 0, base_exp: 20, exp_per_level: 10, base_gold: 40, gold_per_level: 10, hp_per_level: 10, mp_per_level: 10, base_attack: 16, attack_per_level: 9, base_defense: 20, defense_per_level: 10) unless Monster.find_by(name: "Brown Hog")
    Monster.create(name: "Red Hog", max_hp: 50, max_mp: 0, base_exp: 20, exp_per_level: 10, base_gold: 40, gold_per_level: 10, hp_per_level: 20, mp_per_level: 20, base_attack: 20, attack_per_level: 10, base_defense: 25, defense_per_level: 10) unless Monster.find_by(name: "Red Hog")
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
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 4, subclass_type: "Consumable")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 5, subclass_type: "Consumable")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 4, subclass_type: "Consumable")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 5, subclass_type: "Consumable")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 2, subclass_type: "Consumable")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 4, subclass_type: "Consumable")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 1, subclass_type: "Consumable")

    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 1, subclass_type: "Hat")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 2, subclass_type: "Hat")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 1, subclass_type: "Top")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 1, subclass_type: "Bottom")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 2, subclass_type: "Bottom")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 1, subclass_type: "Shoes")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 2, subclass_type: "Top")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 2, subclass_type: "Shoes")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 3, subclass_type: "Bottom")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 3, subclass_type: "Shoes")
    Item.create(owner_id: 1, owner_type: "Vendor", subclass_id: 4, subclass_type: "Hat")


    # ------------------------------------------------------

  end


  private
  def not_authenticated
  	redirect_to login_path, alert: "Please login first"
	end

end
