class AddtypeToWeaponsAndConsumables < ActiveRecord::Migration
  def change
  	create_table :skills, force: true do |t|
    t.integer  :subclass_id,   default: 1
    t.integer  :owner_id,      default: 999
    t.string   :owner_type,    default: "Monster"
    t.string   :subclass_type, default: "Attack"
    t.string   :level,	 			 default: 1
    t.datetime :created_at
    t.datetime :updated_at
  end

  	add_column :weapons, :type, :string
  	add_column :consumables, :type, :string
  	add_column , :type, :string

  end
end
