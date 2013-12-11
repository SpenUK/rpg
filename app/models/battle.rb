class Battle < ActiveRecord::Base

  has_many :battlers, class_name: "Character", foreign_key: "challenger_id"
  has_many :battlers, class_name: "Character", foreign_key: "defender_id"

end
