class User < ActiveRecord::Base
	authenticates_with_sorcery!

  validates :password, length: { in: 6..128 }, on: :create
  validates :password, length: { in: 6..128 }, on: :update

  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  has_many :characters

  def selected_character

    selected = characters.find_by(selected: true) || false


  end


end