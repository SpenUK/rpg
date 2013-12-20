module ApplicationHelper

  def flash_class(type)

    case type
    when :alert
      "alert-error"
    when :notice
      "alert-success"
    else
      ""
    end
  end

	def current_char
    if current_user.selected_character
  	  Character.find(current_user.selected_character)
    else
      false
    end
  end

  def current_location
    if current_char
      current_char.last_location_id
    else
      false
    end
  end

  def all_messages
    messages =[]

    current_char.sent_messages.each do |msg|
      messages << msg
    end
    current_char.received_messages.each do |msg|
      messages << msg
    end
    current_char.sent_battle_requests.each do |msg|
      messages << msg
    end
    current_char.received_battle_requests.each do |msg|
      messages << msg
    end

    messages.sort!{|a,b|b.updated_at <=> a.updated_at}
  end

  def current_message_count
    msg = current_char.received_messages.length
    br = current_char.received_battle_requests.length

    msg + br
  end

	def battle_session
    if current_char.battle_session
		  current_char.battle_session
    else
      nil
    end
	end

  def level_up_check(level, current_xp)
    if current_xp >= level_exp(level)
      current_xp - level_exp(level)
    else
      nil
    end
  end

  def level_exp(level)

  increment = 9.2

  x = (((level * increment) * (level * increment)) * 0.2) + 50

  x.floor

  end
end



