class BattleRequest < ActiveRecord::Base

	belongs_to :sender, class_name: "Character", foreign_key: 'sender_id'
	belongs_to :target, class_name: "Character", foreign_key: 'target_id'

	def sender
		Character.find(sender_id)
	end

	def receiver
		Character.find(target_id)
	end
end

