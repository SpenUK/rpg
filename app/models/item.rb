class Item < ActiveRecord::Base
	include ActiveModel::Serialization

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



end
