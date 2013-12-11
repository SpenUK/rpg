module ApplicationHelper

	def current_char
  	Character.find(current_user.selected_character_id)
	end

	def battle_session
		current_char.battles.first
	end
	
end
