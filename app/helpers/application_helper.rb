module ApplicationHelper

  def flash_class(type)

    case type
    when :alert
      "error"
    when :notice
      "success"
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

  def level_up_check(character)

    current_xp = character.exp
    level = character.level

    if current_xp >= level_exp(level)
      exp_remainder = current_xp - level_exp(level)

      level_up(character, exp_remainder)
    else
      nil
    end
  end

  def level_exp(level)

  increment = 9.2

  x = (((level * increment) * (level * increment)) * 0.2) + 50

  x.floor

  end

  def level_up(char, exp_remainder)

    char.level = char.level + 1
    char.exp = exp_remainder
    char.stats_to_spend = char.stats_to_spend + 5

    random_chance = (rand(2500) - char.stat_luck)
    random_hp_mp = random_chance <= 0 ? random_chance.abs : 0

    hp_gain = (12 + (char.stat_strength) * 0.25).to_i + char.level + (rand(char.level + char.stat_luck) * 0.2).to_i + random_hp_mp
    mp_gain = (12 + (char.stat_int) * 0.5).to_i + char.level + (rand(char.level + char.stat_luck) * 0.2).to_i + random_hp_mp
    
    char.max_hp = char.max_hp + hp_gain
    char.max_mp = char.max_mp + mp_gain

    char.save

    level_up_check(char)

  end
end



