class Vendor < ActiveRecord::Base

	has_and_belongs_to_many :consumables

	has_many :item_instances, as: :owner

end
