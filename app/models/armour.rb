class Armour < ActiveRecord::Base

	# --------------------------------------------------

		has_many :items, as: :subclass

	# --------------------------------------------------

end
