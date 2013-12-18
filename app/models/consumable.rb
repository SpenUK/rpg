class Consumable < ActiveRecord::Base

	has_many :items, as: :subclass
	
end
