class Message < ActiveRecord::Base

	belongs_to :sender, class_name: "User", foreign_key: 'sender_id'
	belongs_to :reciever, class_name: "User", foreign_key: 'user_id'

	def sender
		User.find(sender_id)
	end

	def receiver
		User.find(sender_id)
	end

	def display_type
		message_type.gsub(/_/, ' ')
	end

	def sender_name
	end

	def receiver_name
	end

end
