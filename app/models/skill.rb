class Skill < ActiveRecord::Base
	include ActiveModel::Serialization

	has_many :characters





	def self.get_skill index
		skills = [

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
				mp_consumption: 0
				},
				{
				type: 'Buff',
				name: 'Focus',
				turns: 3,
				defense_up: 0,
				attack_up: 100,
				mp_consumption: 0
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

		skill = skills[index]

	end

	class Attack < Skill
		attr_accessor :name, :type, :mp_consumption, :dmg, :critical, :message_format
		def initialize(name, type, base_dmg, dmg_range, mp_consumption, skill_level)
				@name = name
				@type = type
				@level = skill_level
				@base_dmg = (base_dmg * (0.5 + (skill_level / 10))).round || 2
				@dmg_range = dmg_range || 2
				@mp_consumption = mp_consumption || 0
				@critical = true if rand > 0.8
  			@dmg = (@base_dmg + rand(@dmg_range))
  			@dmg = (@dmg * 1.8).round if @critical
		end

		def attributes
			{'type' => 'Attack', 'name' => @name ,'level' => @level, 'damage' => @dmg, 'critical' => @critical}
		end

  	@message_format = "<caster> attacked <target> with #{@name} for #{@dmg} damage! #{ '(Critial!)' if @critical }"
	end

	class Support < Skill
		attr_accessor :name, :type, :mp_consumption, :added_hp, :added_mp, :message_format 
		def initialize(name, type, hp_regen, mp_regen, mp_consumption, skill_level)
				@name = name
				@type = type
				@level = skill_level
				@mp_consumption = mp_consumption || 0
				@added_hp = hp_regen 
				@added_mp = mp_regen 
				@mp_consumption = mp_consumption

		end


		def attributes
			{'type' => 'Support', 'name' => @name, 'added_hp' => @added_hp, 'added_mp' => @added_mp}
		end

		@message_format = "<caster> used <skill>!"
	end

	def self.process_skill(index, skill_level, caster, target, battle_id)

		skill = get_skill(index)
		type = skill[:type]


		if skill[:type] == 'Attack'

			new_skill = Attack.new( skill[:name], skill[:type], skill[:base_dmg], skill[:dmg_range], skill[:mp_consumption], skill_level)

			if caster.current_mp < new_skill.mp_consumption
				skill = "NotEnoughMP"
			else
				caster.current_mp -= new_skill.mp_consumption

				target.current_hp -= new_skill.dmg if target.current_hp > 0
				target.current_hp = 0 if target.current_hp < 0
			end

		elsif skill[:type] =='Buff'

		elsif skill[:type] =='Support'

			new_skill = Support.new(skill[:name], skill[:type], skill[:hp_regen], skill[:mp_regen], skill[:mp_consumption], skill_level)

			if caster.current_mp < new_skill.mp_consumption
				skill = "NotEnoughMP"
			else
				caster.current_mp -= new_skill.mp_consumption

				caster.current_hp += new_skill.added_hp
				caster.current_hp = caster.max_hp if caster.current_hp > caster.max_hp

				caster.current_mp += new_skill.added_mp
				caster.current_mp = caster.max_mp if caster.current_mp > caster.max_mp
			end

		end

		if skill != "NotEnoughMP"

			target.save
			caster.save
			
			skill_hash = new_skill.attributes

			FightTurn.create( maker_id: caster.id, maker_type: "Character", maker_name: caster.name,
									target_id: target.id, target_type: "Character", target_name: target.name,
									fight_type: "Battle", fight_id: battle_id, 
									serialized_object: skill_hash.to_json
									)
		end


		return skill
	end

end
