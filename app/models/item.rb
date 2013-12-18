class Item < ActiveRecord::Base

	# --------------------------------------------------

		belongs_to :owner, polymorphic: true

		belongs_to :subclass, polymorphic: true

	# --------------------------------------------------


end
