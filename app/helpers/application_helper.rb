module ApplicationHelper

	def current_char
  	Character.find(current_user.selected_character_id)
	end
	
end
