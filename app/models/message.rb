class Message < ActiveRecord::Base

	belongs_to :sender, class_name: "Character", foreign_key: 'sender_id'
	belongs_to :target, class_name: "Character", foreign_key: 'target_id'

	def sender
		Character.find(sender_id)
	end

	def receiver
		Character.find(sender_id)
	end

	def display_type
		message_type.gsub(/_/, ' ')
	end

	def display_time
	end

	def sender_name
	end

	def receiver_name
	end

end
