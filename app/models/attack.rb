class Attack < ActiveRecord::Base

	has_and_belongs_to_many :characters
	has_and_belongs_to_many :monsters
end
