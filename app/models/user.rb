class User < ActiveRecord::Base
	authenticates_with_sorcery!

	validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  has_many :characters

  has_many :sent_messages, :class_name => "Message", foreign_key: "sender_id"
  has_many :received_messages, :class_name => "Message", foreign_key: "user_id"



  def selected_char
  	Character.find(selected_character_id)
  end


end
