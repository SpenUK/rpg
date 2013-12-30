class Skill < ActiveRecord::Base
	include CharacterSkills

	has_many :characters

	def self.get_skill index
		skills = [
				{
				type: 'Attack',
				name: 'Punch',
				base_dmg: 6,
				dmg_range: 2,
				mp_consumption: 0
				},

				{
				type: 'Attack',
				name: 'Kick',
				base_dmg: 4,
				dmg_range: 6,
				mp_consumption: 0
				},

				{
				type: 'Attack',
				name: 'Slash',
				base_dmg: 10,
				dmg_range: 6,
				mp_consumption: 0
				},
		#--------- Buff skills -----------
				{
				type: 'Buff',
				name: 'Focus',
				turns: 3,
				defense_up: 0,
				attack_up: 100,
				mp_consumption: 0
				},


		#--------- Support skills -------- 
				{
				type: 'Support',
				name: 'Heal',
				hp_regen: 20,
				mp_regen: 0,
				mp_consumption: 10
				},

				{
				type: 'Support',
				name: 'meditate',
				hp_regen: 0,
				mp_regen: 10,
				mp_consumption: 0
				}


		]

		skill = skills[index]

	end

	class Skill
		include ActiveModel::Serialization
		
	end

	class Attack < Skill
		attr_accessor :name, :mp_consumption, :dmg, :critical, :message_format
		def initialize(name, base_dmg, dmg_range, mp_consumption, skill_level)
				@name = name
				@level = skill_level
				@base_dmg = base_dmg * (0.5 + (skill_level / 10)) || 2
				@dmg_range = dmg_range || 2
				@mp_consumption = mp_consumption || 0
				@critical = true if rand > 0.8
  			@dmg = (@base_dmg + rand(@dmg_range))
  			@dmg = (@dmg * 1.8).round if @critical
		end

		def attributes
			{'type' => 'Support', 'name' => @name ,'level' => @level, 'damage' => @dmg, 'critical' => @critical}
		end

  	@message_format = "<caster> attacked <target> with #{@name} for #{@dmg} damage! #{ '(Critial!)' if @critical }"
	end

	class Support < Skill
		attr_accessor :name, :mp_consumption, :added_hp, :added_mp, :message_format 
		def initialize(name, hp_regen, mp_regen, mp_consumption, skill_level)
				@name = name
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

			skill = Attack.new( skill[:name], skill[:base_dmg], skill[:dmg_range], skill[:mp_consumption], skill_level)

			caster.current_mp -= skill.mp_consumption

			target.current_hp -= skill.dmg if target.current_hp > 0
			target.current_hp = 0 if target.current_hp < 0

		elsif skill[:type] =='Buff'

		elsif skill[:type] =='Support'

			skill = Support.new(skill[:name], skill[:hp_regen], skill[:mp_regen], skill[:mp_consumption], skill_level)

			caster.current_mp -= skill.mp_consumption

			caster.current_hp += skill.added_hp
			caster.current_hp = caster.max_hp if caster.current_hp > caster.max_hp

			caster.current_mp += skill.added_mp
			caster.current_mp = caster.max_mp if caster.current_mp > caster.max_mp


		end

		target.save
		caster.save

		skill_hash = skill.attributes

FightTurn.create( maker_id: caster.id, maker_type: "Character", 
									target_id: target.id, target_type: "Character", 
									fight_type: "Battle", fight_id: battle_id, 
									serialized_object: skill_hash.to_json
									)


		return skill
	end

end