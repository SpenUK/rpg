class FightTurn < ActiveRecord::Base

	belongs_to :fight, polymorphic: true
	belongs_to :maker, polymorphic: true
	belongs_to :target, polymorphic: true

	def display_message(subject)

		object = JSON.parse(serialized_object)

		if subject == :maker
			
			if object["type"] == "Attack"
				object.inspect
				
			elsif object["type"] == "Support"
				object.inspect

			elsif object["type"] == "Buff"
				object.inspect

			elsif object["type"] == "Consumable"
				object.inspect

			elsif object["type"] == "AttackPotion"
				object.inspect

			elsif object["type"] == "BuffPotion"
				object.inspect

			end

		elsif subject == :target
			
			"object.inspect"

		end

	end

end
