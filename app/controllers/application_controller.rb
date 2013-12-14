class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :require_login

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

    # Attack.create(title: 'power_slash', melee: true, elemental: 'normal', physical: true, base_dmg: 14, dmg_range: 12, mp_consumption: 10 ) unless Attack.find_by(title: 'power_slash')
  end


  private
  def not_authenticated
  	redirect_to login_path, alert: "Please login first"
	end

end
