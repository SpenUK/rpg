class Skill < ActiveRecord::Base
	include ActiveModel::Serialization

	belongs_to :character

	def get_skill index
		attacks = [

				{ type: 'none', name: 'none' },

				{
				type: 'Attack',
				name: 'Punch',
				elemental: 'normal',
				base_dmg: 6,
				dmg_range: 2,
				mp_consumption: 0
				},

				{
				type: 'Attack',
				name: 'Kick',
				elemental: 'normal',
				base_dmg: 5,
				dmg_range: 7,
				mp_consumption: 0
				},

				{
				type: 'Attack',
				name: 'Slash',
				elemental: 'normal',
				base_dmg: 14,
				dmg_range: 8,
				mp_consumption: 10
				},

				{
				type: 'Buff',
				name: 'Focus',
				turns: 3,
				defense_up: 0,
				attack_up: 100,
				mp_consumption: 10
				},

				{
				type: 'Buff',
				name: 'Solid Stance',
				turns: 3,
				defense_up: 100,
				attack_up: 0,
				mp_consumption: 10
				},

				{ 
				type: 'Support',
				name: 'Heal',
				hp_regen: 20,
				mp_regen: 0,
				hp_per_level: 4,
				mp_per_level: 0,
				mp_consumption: 10,
				consumption_per_level: 1
				},

				{
				type: 'Support',
				name: 'meditate',
				hp_regen: 0,
				mp_regen: 10,
				hp_per_level: 0,
				mp_per_level: 2,
				mp_consumption: 0,
				consumption_per_level: 0
				}
		]

		attack = attacks[index]
	end

	def self.get_attack index
		attacks = [

				{ type: 'none', name: 'none' },

				{
				type: 'Attack',
				name: 'Punch',
				elemental: 'normal',
				base_dmg: 6,
				dmg_range: 2,
				mp_consumption: 0
				},

				{
				type: 'Attack',
				name: 'Kick',
				elemental: 'normal',
				base_dmg: 5,
				dmg_range: 7,
				mp_consumption: 0
				},

				{
				type: 'Attack',
				name: 'Slash',
				elemental: 'normal',
				base_dmg: 14,
				dmg_range: 8,
				mp_consumption: 10
				}
		]

		attack = attacks[index]
	end

	def self.get_buff index
		buffs = [

				{ type: 'none', name: 'none' },

				{
				type: 'Buff',
				name: 'Focus',
				turns: 3,
				defense_up: 0,
				attack_up: 100,
				mp_consumption: 10
				},

				{
				type: 'Buff',
				name: 'Solid Stance',
				turns: 3,
				defense_up: 100,
				attack_up: 0,
				mp_consumption: 10
				}
		]

		buff = buffs[index]
	end

	def self.get_support index
		supports = [

				{ type: 'none', name: 'none' },

				{ 
				type: 'Support',
				name: 'Heal',
				hp_regen: 20,
				mp_regen: 0,
				hp_per_level: 4,
				mp_per_level: 0,
				mp_consumption: 10,
				consumption_per_level: 1
				},

				{
				type: 'Support',
				name: 'meditate',
				hp_regen: 0,
				mp_regen: 10,
				hp_per_level: 0,
				mp_per_level: 2,
				mp_consumption: 0,
				consumption_per_level: 0
				}
		]

		support = supports[index]
	end

	class Attack < Skill
		attr_accessor :name, :type, :mp_consumption, :dmg, :critical, :message_format
		def initialize(name, type, base_dmg, dmg_range, mp_consumption, skill_level, index)
				@name = name
				@type = type
				@level = skill_level
				@base_dmg = (base_dmg * (0.5 + (skill_level / 10))).round || 2
				@dmg_range = dmg_range || 2
				@mp_consumption = mp_consumption || 0
				@critical = true if rand > 0.8
  			@dmg = (@base_dmg + rand(@dmg_range))
  			@dmg = (@dmg * 1.8).round if @critical
  			@index = index
		end

		def process caster, target
				caster.current_mp -= @mp_consumption

				target.current_hp -= @dmg if target.current_hp > 0
				target.current_hp = 0 if target.current_hp < 0
		end

		def attributes
			{'type' => 'Attack', 'name' => @name ,'level' => @level, 'damage' => @dmg, 'critical' => @critical, 'mp_consumption' => @mp_consumption, 'index' => @index }
		end
	end

	class Buff < Skill
		attr_accessor :name, :type, :mp_consumption, :dmg, :critical, :message_format
		def initialize(name, type, turns, defense_up, attack_up, mp_consumption, skill_level, index)

				@name = name
				@type = type
				@level = skill_level
				@turns = turns
				@defense_up = defense_up
				@attack_up = attack_up
				@mp_consumption = mp_consumption || 0
				@index = index

		end

		def process caster, target
			caster.current_mp -= @mp_consumption
		end

		def attributes
			{'type' => 'Buff', 'name' => @name ,'level' => @level, 'damage' => @dmg, 'critical' => @critical, 'mp_consumption' => @mp_consumption, 'index' => @index }
		end
	end

	class Support < Skill
		attr_accessor :name, :type, :mp_consumption, :added_hp, :added_mp, :message_format 
		def initialize(name, type, hp_regen, mp_regen, mp_consumption, skill_level, index)
				@name = name
				@type = type
				@level = skill_level
				@mp_consumption = mp_consumption || 0
				@added_hp = hp_regen 
				@added_mp = mp_regen 
				@mp_consumption = mp_consumption
				@index = index
		end

		def process caster, target
				caster.current_mp -= @mp_consumption

				caster.current_hp += @added_hp
				caster.current_hp = caster.max_hp if caster.current_hp > caster.max_hp

				caster.current_mp += @added_mp
				caster.current_mp = caster.max_mp if caster.current_mp > caster.max_mp
		end

		def attributes
			{'type' => 'Support', 'name' => @name, 'added_hp' => @added_hp, 'added_mp' => @added_mp, 'mp_consumption' => @mp_consumption, 'index' => @index }
		end
	end

	def build_skill(id)

		skill = get_skill(id)
		@type = skill[:type]

		if skill[:type] == 'Attack'
			new_skill = Attack.new( skill[:name], skill[:type], skill[:base_dmg], skill[:dmg_range], skill[:mp_consumption], level, id)
		elsif skill[:type] =='Buff'
			new_skill = Buff.new(skill[:name], skill[:type], skill[:turns], skill[:defense_up], skill[:attack_up], skill[:mp_consumption], level, id)
		elsif skill[:type] =='Support'
			new_skill = Support.new(skill[:name], skill[:type], skill[:hp_regen], skill[:mp_regen], skill[:mp_consumption], level, id)
		end

		return new_skill
	end

	def process_skill(aggression_id = 1)

		current_fight = character.battle_session.fight
	
		caster = character
		target = current_fight.challenger_id == caster.id ? current_fight.defender : current_fight.challenger

		new_skill = build_skill skill_id

		if caster.current_mp < new_skill.mp_consumption
			return "NotEnoughMP"
		else
			new_skill.process(caster, target)

			target.save
			caster.save
			
			skill_hash = new_skill.attributes

			if defined? target.name
				target_name = target.name
			else 
				target_name = target.species.name
			end

			if defined? caster.name
				caster_name = caster.name
			else 
				caster_name = caster.species.name
			end

				target_type = target.is_a?(Character) ? "Character" : "Mob"
				caster_type = caster.is_a?(Character) ? "Character" : "Mob"

			FightTurn.create( maker_id: caster.id, maker_type: caster_type, maker_name: caster_name,
									target_id: target.id, target_type: target_type, target_name: target_name,
									fight_type: current_fight.class.to_s, fight_id: current_fight.id, 
									serialized_object: skill_hash.to_json
									)

			return new_skill.attributes
		end
	end

end
