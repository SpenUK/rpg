class Monster < ActiveRecord::Base

	has_many :mobs, as: :species

	has_and_belongs_to_many :attacks

end
