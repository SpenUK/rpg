class Item < ActiveRecord::Base
	include ActiveModel::Serialization
	# include ApplicationHelper

	# --------------------------------------------------

		belongs_to :owner, polymorphic: true
		belongs_to :subclass, polymorphic: true

	# --------------------------------------------------

	class Itembase
	end

	class Equipable < Itembase
	end

	class Hat < Equipable
	end

	class Top < Equipable

	end

	class Bottom < Equipable
	end

	class Shoes < Equipable
	end

	class Weapon < Equipable

		attr_accessor :name, :description, :base_dmg, :dmg_range, :base_price, :rarity, :image_url, :type, :id
		def initialize( name, description, base_dmg, dmg_range, base_price, image_url, rarity, type, id
			)
			@name = name
			@description = description
			@base_dmg = base_dmg
			@dmg_range = dmg_range
			@base_price = base_price
			@image_url = image_url
			@rarity = rarity
			@type = type
			@id = id
		end
	end

	#---------------------

	class Consumable

		attr_accessor :name, :description, :base_price, :rarity, :image_url, :type, :hp_regen, :mp_regen, :id
		def initialize( name, description, hp_regen, mp_regen, base_price, rarity, image_url, type, id
			)
			@name = name
			@description = description
			@hp_regen = hp_regen
			@mp_regen = mp_regen
			@base_price = base_price
			@image_url = image_url
			@rarity = rarity
			@type = type
			@id = id
		end

		def attributes
			{'type' => 'Consumable', 'name' => @name, 'hp_regen' => @hp_regen, 'mp_regen' => @mp_regen}
		end
	end

	class Food < Consumable
	end

	class MP_HP_Potion < Consumable #---------------------
	end

	class AttackPotion < Consumable
	end

	class BuffPotion < Consumable
	end

	def build_item
		@type = subclass_type
		@index = subclass_id

		if @type == 'Consumable'
			@item = self.class.get_consumable(@index)
			@new_item = Consumable.new(@item[:name], @item[:description], @item[:hp_regen], @item[:mp_regen], @item[:base_price], @item[:rarity], @item[:image_url], @item[:type], id)

		elsif @type == 'Weapon'
			@item = self.class.get_weapon(@index)
			@new_item = Weapon.new(@item[:name], @item[:description], @item[:base_dmg], @item[:dmg_range], @item[:base_price], @item[:image_url], @item[:rarity], @item[:type], id )

		end
	end

	def self.get_item index
		items = [

				{ type: 'none', name: 'none' },

				{
				type: 'Consumable',
				name: 'Green Apple',
				description: 'A tasty green apple.',
				hp_regen: 15,
				mp_regen: 0,
				base_price: 20,
				rarity: 15,
				image_url: 'items/green_apple.png'
				},

				{
				type: 'Consumable',
				name: 'Red Apple',
				description: 'A tasty Red Apple',
				hp_regen: 15,
				mp_regen: 0,
				base_price: 40,
				rarity: 25,
				image_url: 'items/red_apple.png'
				},

				{
				type: 'Consumable',
				name: 'Old Cheese',
				description: 'Eww, this cheese stinks!',
				hp_regen: 5,
				mp_regen: 15,
				base_price: 40,
				rarity: 15,
				image_url: 'items/green_apple.png'
				},

				{
				type: 'Consumable',
				name: 'Red Vial',
				description: 'A small vial of healing potion',
				hp_regen: 20,
				mp_regen: 0,
				base_price: 50,
				rarity: 35,
				image_url: 'items/green_apple.png'
				},

				{
				type: 'Consumable',
				name: 'Blue Vial',
				description: 'A small vial of mana potion',
				hp_regen: 0,
				mp_regen: 20,
				base_price: 70,
				rarity: 45,
				image_url: 'items/green_apple.png'
				},

				{
				type: 'Sword',
				name: 'Tiny Sword',
				elemental: 'normal',
				base_dmg: 10,
				dmg_range: 6,
				base_price: 320,
				rarity: 1100,
				image_url: 'blah.png'
				},

				{
				type: 'Sword',
				name: 'Steel Sword',
				elemental: 'normal',
				base_dmg: 20,
				dmg_range: 10,
				base_price: 1120,
				rarity: 2000,
				image_url: 'items/sword_2.png'
				},

				{
				type: 'Sword',
				name: 'Rusty Sword',
				elemental: 'normal',
				base_dmg: 8,
				dmg_range: 3,
				base_price: 120,
				rarity: 200,
				image_url: 'items/rusty_sword.png'
				},

				{
				type: 'Sword',
				name: 'Carrot Sword',
				description: "Is it a sword? no. no it's a carrot.",
				elemental: 'normal',
				base_dmg: 40,
				dmg_range: 10,
				base_price: 30020,
				rarity: 99999,
				image_url: 'items/carrot_sword.png'
				},

				{
				type: 'Helmet',
				name: 'Old cap',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				},

				{
				type: 'Top',
				name: 'White teeshirt',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				},

				{
				type: 'Top',
				name: 'Brown teeshirt',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				},

				{
				type: 'Top',
				name: 'Black sweater',
				elemental: 'normal',
				defence: 5,
				elemental_resist: 0,
				rarity: 105,
				image_url: 'blah.png'
				},

				{
				type: 'Top',
				name: 'Red sweater',
				elemental: 'normal',
				defence: 5,
				elemental_resist: 0,
				rarity: 105,
				image_url: 'blah.png'
				},

				{
				type: 'Shoes',
				name: 'Tatty shoes',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				},

				{
				type: 'bottoms',
				name: 'Blue jeans',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				},

				{
				type: 'bottoms',
				name: 'Black jeans',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				},

				{
				type: 'bottoms',
				name: 'Brown jeans',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				}

		]

		item = items[index]
	end

	def self.get_consumable index
		consumables = [

				{ type: 'none', name: 'none' },

				{
				type: 'Consumable',
				name: 'Green Apple',
				description: 'A tasty green apple.',
				hp_regen: 15,
				mp_regen: 0,
				base_price: 20,
				rarity: 15,
				image_url: 'items/green_apple.png'
				},

				{
				type: 'Consumable',
				name: 'Red Apple',
				description: 'A tasty Red Apple',
				hp_regen: 15,
				mp_regen: 0,
				base_price: 40,
				rarity: 25,
				image_url: 'items/red_apple.png'
				},

				{
				type: 'Consumable',
				name: 'Old Cheese',
				description: 'Eww, this cheese stinks!',
				hp_regen: 5,
				mp_regen: 15,
				base_price: 40,
				rarity: 15,
				image_url: 'items/old_cheese.png'
				},

				{
				type: 'Consumable',
				name: 'Red Vial',
				description: 'A small vial of healing potion',
				hp_regen: 20,
				mp_regen: 0,
				base_price: 50,
				rarity: 35,
				image_url: 'items/green_apple.png'
				},

				{
				type: 'Consumable',
				name: 'Blue Vial',
				description: 'A small vial of mana potion',
				hp_regen: 0,
				mp_regen: 20,
				base_price: 70,
				rarity: 45,
				image_url: 'items/green_apple.png'
				}

		]

		consumable = consumables[index]
	end

	def self.get_equipable index
		equipables = [

				{ type: 'none', name: 'none' },

				{
				type: 'Helmet',
				name: 'Old cap',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				},

				{
				type: 'Top',
				name: 'White teeshirt',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				},

				{
				type: 'Top',
				name: 'Brown teeshirt',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				},

				{
				type: 'Top',
				name: 'Black sweater',
				elemental: 'normal',
				defence: 5,
				elemental_resist: 0,
				rarity: 105,
				image_url: 'blah.png'
				},

				{
				type: 'Top',
				name: 'Red sweater',
				elemental: 'normal',
				defence: 5,
				elemental_resist: 0,
				rarity: 105,
				image_url: 'blah.png'
				},

				{
				type: 'Shoes',
				name: 'Tatty shoes',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				},

				{
				type: 'bottoms',
				name: 'Blue jeans',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				},

				{
				type: 'bottoms',
				name: 'Black jeans',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				},

				{
				type: 'bottoms',
				name: 'Brown jeans',
				elemental: 'normal',
				defence: 2,
				elemental_resist: 0,
				rarity: 15,
				image_url: 'blah.png'
				}

		]

		equipable = equipables[index]
	end

	def self.get_weapon index
		weapons = [

				{ type: 'none', name: 'none' },

				{
				type: 'Sword',
				name: 'Tiny Sword',
				description: "Blah",
				elemental: 'normal',
				base_dmg: 10,
				dmg_range: 6,
				base_price: 320,
				rarity: 1100,
				image_url: 'blah.png'
				},

				{
				type: 'Sword',
				name: 'Steel Sword',
				description: "A sword with a strong, shiny blade.",
				elemental: 'normal',
				base_dmg: 20,
				dmg_range: 10,
				base_price: 1120,
				rarity: 2000,
				image_url: 'items/sword_2.png'
				},

				{
				type: 'Sword',
				name: 'Rusty Sword',
				description: "This sword has seen better days.",
				elemental: 'normal',
				base_dmg: 8,
				dmg_range: 3,
				base_price: 120,
				rarity: 200,
				image_url: 'items/rusty_sword.png'
				},

				{
				type: 'Sword',
				name: 'Carrot Sword',
				description: "Is it a sword? no. no it's a carrot.",
				elemental: 'normal',
				base_dmg: 40,
				dmg_range: 10,
				base_price: 30020,
				rarity: 99999,
				image_url: 'items/carrot_sword.png'
				},

				{
				type: 'Sword',
				name: '2nd Carrot Sword',
				description: "Is it a sword? no. no it's a carrot.",
				elemental: 'normal',
				base_dmg: 90,
				dmg_range: 10,
				base_price: 30020,
				rarity: 99999,
				image_url: 'items/carrot_sword.png'
				}

		]

		weapon = weapons[index]
	end

#----------------------

	def equip_item(slot_id)

		no_save = false

		equipped = already_equipped(self.id.to_i)

		if equipped == false
			case slot_id
			when 'hat'
				self.owner.hat_id = self.id
			when 'top'
				self.owner.top_id = self.id
			when 'bottoms'
				self.owner.bottoms_id = self.id
			when 'weapon'
				self.owner.right_hand_id = self.id
			when 'shield'
				self.owner.left_hand_id = self.id
			when 'shoes'
				self.owner.shoes_id = self.id
			when 'consumable1'
				self.owner.held1_id = self.id
			when 'consumable2'
				self.owner.held2_id = self.id
			when 'consumable3'
				self.owner.held3_id = self.id
			when 'consumable4'
				self.owner.held4_id = self.id
			when 'consumable5'
				self.owner.held5_id = self.id
			when 'consumable6'
				self.owner.held6_id = self.id
			when 'consumable7'
				self.owner.held7_id = self.id
			when 'consumable8'
				self.owner.held8_id = self.id
			else
				no_save = true
			end

			self.owner.save unless no_save

		elsif equipped.is_a?(Integer)

			@self = self

			case slot_id
			when 'consumable1'
				

				self.owner.held2_id = self.owner.held1_id if equipped == 1
				self.owner.held3_id = self.owner.held1_id if equipped == 2
				self.owner.held4_id = self.owner.held1_id if equipped == 3
				self.owner.held5_id = self.owner.held1_id if equipped == 4
				self.owner.held6_id = self.owner.held1_id if equipped == 5
				self.owner.held7_id = self.owner.held1_id if equipped == 6
				self.owner.held8_id = self.owner.held1_id if equipped == 7

				self.owner.held1_id = self.id
			when 'consumable2'
				self.owner.held1_id = self.owner.held2_id if equipped == 0
				self.owner.held3_id = self.owner.held2_id if equipped == 2
				self.owner.held4_id = self.owner.held2_id if equipped == 3
				self.owner.held5_id = self.owner.held2_id if equipped == 4
				self.owner.held6_id = self.owner.held2_id if equipped == 5
				self.owner.held7_id = self.owner.held2_id if equipped == 6
				self.owner.held8_id = self.owner.held2_id if equipped == 7

				self.owner.held2_id = self.id
			when 'consumable3'
				self.owner.held1_id = self.owner.held3_id if equipped == 0
				self.owner.held2_id = self.owner.held3_id if equipped == 1
				# self.owner.held3_id = self.owner.held3_id if equipped == 2
				self.owner.held4_id = self.owner.held3_id if equipped == 3
				self.owner.held5_id = self.owner.held3_id if equipped == 4
				self.owner.held6_id = self.owner.held3_id if equipped == 5
				self.owner.held7_id = self.owner.held3_id if equipped == 6
				self.owner.held8_id = self.owner.held3_id if equipped == 7

				self.owner.held3_id = self.id
			when 'consumable4'
				self.owner.held1_id = self.owner.held4_id if equipped == 0
				self.owner.held2_id = self.owner.held4_id if equipped == 1
				self.owner.held3_id = self.owner.held4_id if equipped == 2
				# self.owner.held4_id = self.owner.held4_id if equipped == 3
				self.owner.held5_id = self.owner.held4_id if equipped == 4
				self.owner.held6_id = self.owner.held4_id if equipped == 5
				self.owner.held7_id = self.owner.held4_id if equipped == 6
				self.owner.held8_id = self.owner.held4_id if equipped == 7

				self.owner.held4_id = self.id
			when 'consumable5'
				self.owner.held1_id = self.owner.held5_id if equipped == 0
				self.owner.held2_id = self.owner.held5_id if equipped == 1
				self.owner.held3_id = self.owner.held5_id if equipped == 2
				self.owner.held4_id = self.owner.held5_id if equipped == 3
				# self.owner.held5_id = self.owner.held5_id if equipped == 4
				self.owner.held6_id = self.owner.held5_id if equipped == 5
				self.owner.held7_id = self.owner.held5_id if equipped == 6
				self.owner.held8_id = self.owner.held5_id if equipped == 7

				self.owner.held5_id = self.id
			when 'consumable6'
				self.owner.held1_id = self.owner.held6_id if equipped == 0
				self.owner.held2_id = self.owner.held6_id if equipped == 1
				self.owner.held3_id = self.owner.held6_id if equipped == 2
				self.owner.held4_id = self.owner.held6_id if equipped == 3
				self.owner.held5_id = self.owner.held6_id if equipped == 4
				# self.owner.held6_id = self.owner.held6_id if equipped == 5
				self.owner.held7_id = self.owner.held6_id if equipped == 6
				self.owner.held8_id = self.owner.held6_id if equipped == 7

				self.owner.held6_id = self.id
			when 'consumable7'
				self.owner.held1_id = self.owner.held7_id if equipped == 0
				self.owner.held2_id = self.owner.held7_id if equipped == 1
				self.owner.held3_id = self.owner.held7_id if equipped == 2
				self.owner.held4_id = self.owner.held7_id if equipped == 3
				self.owner.held5_id = self.owner.held7_id if equipped == 4
				self.owner.held6_id = self.owner.held7_id if equipped == 5
				# self.owner.held7_id = self.owner.held7_id if equipped == 6
				self.owner.held8_id = self.owner.held7_id if equipped == 7

				self.owner.held7_id = self.id
			when 'consumable8'
				self.owner.held1_id = self.owner.held8_id if equipped == 0
				self.owner.held2_id = self.owner.held8_id if equipped == 1
				self.owner.held3_id = self.owner.held8_id if equipped == 2
				self.owner.held4_id = self.owner.held8_id if equipped == 3
				self.owner.held5_id = self.owner.held8_id if equipped == 4
				self.owner.held6_id = self.owner.held8_id if equipped == 5
				self.owner.held7_id = self.owner.held8_id if equipped == 6
				# self.owner.held8_id = self.owner.held8_id if equipped == 7

				self.owner.held8_id = self.id
			else
				no_save = true
			end

			self.owner.save unless no_save

		end

		

	end

	def already_equipped(id)
		status = false

		ids = []
		ids << self.owner.hat_id
		ids << self.owner.top_id
		ids << self.owner.bottoms_id
		ids << self.owner.left_hand_id
		ids << self.owner.right_hand_id
		ids << self.owner.shoes_id

		status = 'equipped' if ids.include?(id)

		ids = []
		ids << self.owner.held1_id
		ids << self.owner.held2_id
		ids << self.owner.held3_id
		ids << self.owner.held4_id
		ids << self.owner.held5_id
		ids << self.owner.held6_id
		ids << self.owner.held7_id
		ids << self.owner.held8_id

		status = ids.index(id) if ids.index(id)

		return status
	end


	

end


# elsif already_equipped(self.id.to_i).is_a?(Integer)

# 			case already_equipped
# 			when 1
# 				target_slot = self.owner.held1_id
# 			when 2
# 				target_slot = self.owner.held2_id
# 			when 3
# 				target_slot = self.owner.held3_id
# 			when 4
# 				target_slot = self.owner.held4_id
# 			when 5
# 				target_slot = self.owner.held5_id
# 			when 6
# 				target_slot = self.owner.held6_id
# 			when 7
# 				target_slot = self.owner.held7_id
# 			when 8
# 				target_slot = self.owner.held8_id
# 			end

# 			case slot_id
# 			when 'consumable1'
# 				target_slot = self.owner.held1_id
# 				self.owner.held1_id = self.id
# 			when 'consumable2'
# 				target_slot = self.owner.held2_id
# 				self.owner.held2_id = self.id
# 			when 'consumable3'
# 				target_slot = self.owner.held3_id
# 				self.owner.held3_id = self.id
# 			when 'consumable4'
# 				target_slot = self.owner.held4_id
# 				self.owner.held4_id = self.id
# 			when 'consumable5'
# 				target_slot = self.owner.held5_id
# 				self.owner.held5_id = self.id
# 			when 'consumable6'
# 				target_slot = self.owner.held6_id
# 				self.owner.held6_id = self.id
# 			when 'consumable7'
# 				target_slot = self.owner.held7_id
# 				self.owner.held7_id = self.id
# 			when 'consumable8'
# 				target_slot = self.owner.held8_id
# 				self.owner.held8_id = self.id
# 			else
# 				no_save = true
# 			end

# 			self.owner.save unless no_save

# 		end


