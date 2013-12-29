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

				{
				type: 'Support',
				name: 'Heal',
				hp_regen: 20,
				mp_regen: 0,
				mp_consumption: 10
				}

		]

		skill = skills[index]

	end

	class Attack

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

  	@message_format = "<caster> attacked <target> with <skill> for <dmg> damage!"

	end

	def self.process_skill(index, skill_level, caster, target, battle_id)

		skill = get_skill(index)
		type = skill[:type]

		if skill[:type] == 'Attack'

			skill = Attack.new( skill[:name], skill[:base_dmg], skill[:dmg_range], skill[:mp_consumption], skill_level)

			caster.current_mp -= skill.mp_consumption

			target.current_hp -= skill.dmg if target.current_hp > 0
			target.current_hp = 0 if target.current_hp < 0

			target.save
			caster.save


		elsif skill.type =='Buff'

		elsif skill.type =='Support'

		end

		FightTurn.create( maker_id: caster.id ,maker_type: "Character", target_id: target.id, target_type: "Character", 
						    									damage: skill.dmg, healed: nil, skill_used: skill.name, skill_id: 1, skill_type: type, 
						    									item_used: nil,item_used_id: nil,item_used_type: nil, critical: skill.critical, fight_type: "Battle", fight_id: battle_id )


		return skill
	end

end
