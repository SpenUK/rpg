class Battle < ActiveRecord::Base

# -----------------------
	# has_many :comments
  # has_many :moves
  belongs_to :challenger, :class_name => 'Character', :foreign_key => 'challenger_id'
  belongs_to :defender, :class_name => 'Character', :foreign_key => 'defender_id'
  has_one :battle_session
# -----------------------


end
