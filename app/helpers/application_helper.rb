module ApplicationHelper

	def current_char
    if current_user.selected_character
  	  Character.find(current_user.selected_character)
    else
      false
    end
  end

	def battle_session
		current_char.battles.first
	end
	
end
