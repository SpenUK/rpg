class FightTurn < ActiveRecord::Base

	belongs_to :fight, polymorphic: true
	belongs_to :maker, polymorphic: true
	belongs_to :target, polymorphic: true

	def display_message(subject)

		object = JSON.parse(serialized_object)

		if subject == :maker
			
			if object["type"] == "Attack"

				object.inspect

				"You attacked #{target_name} with #{object['name']} for #{object['damage']} damage"

				
			elsif object["type"] == "Support"

				# object.inspect

				"You used #{object["name"]} and gained #{ object["added_hp"].to_s + ' HP' if object["added_hp"] > 0 }#{ ' and ' if object['added_hp'] > 0 && object['added_mp'] > 0} #{ object['added_mp'].to_s + ' MP' if object['added_mp'] > 0}"

			elsif object["type"] == "Buff"
				object.inspect

			elsif object["type"] == "Consumable"
				object.inspect

				"You used #{object['name']} and gained #{ object['added_hp'].to_s + ' HP' if object['added_hp'] > 0 }#{ ' and ' if object['added_hp'] > 0 && object['added_mp'] > 0} #{ object['added_mp'].to_s + ' MP' if object['added_mp'] > 0}"

			elsif object["type"] == "AttackPotion"
				object.inspect

			elsif object["type"] == "BuffPotion"
				object.inspect

			end

		elsif subject == :target
			
			object.inspect

		end

	end

end
