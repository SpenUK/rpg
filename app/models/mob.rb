class Mob < ActiveRecord::Base

	belongs_to :species, polymorphic: true
	belongs_to :mob_battle

	has_many :sent_fight_turns, class_name: "FightTurn", as: :maker
	has_many :received_fight_turns, class_name: "FightTurn", as: :target


	#------------------------------------------

	def self.struggle
		{
				type: 'Attack',
				name: 'Struggly',
				elemental: 'normal',
				base_dmg: 5,
				dmg_range: 3,
				mp_consumption: 0
		}
	end

	def self.get_attack index
		attacks = [

				{ type: 'none', name: 'none' },

				{
				type: 'Attack',
				name: 'Scratch',
				elemental: 'normal',
				base_dmg: 6,
				dmg_range: 2,
				mp_consumption: 0
				},

				{
				type: 'Attack',
				name: 'Bite',
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
				}
		]

		attack = attacks[index]
	end # 3

	def self.get_buff index
		mob_skills = [

				{ type: 'none', name: 'none' },

				{
				type: 'Buff',
				name: 'Focus',
				turns: 3,
				defense_up: 0,
				attack_up: 100,
				mp_consumption: 0
				}
		]

		mob_skill = mob_skills[index]
	end # 1

	def self.get_support index
		support = [

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
	end # 2

	def build_skill type, index, skill_level

		@type = type
		@index = index

		if @type == 'Attack'
			@skill = self.class.get_attack(@index)
			@new_skill = Attack.new( @skill[:name], @skill[:type], @skill[:base_dmg], @skill[:dmg_range], @skill[:mp_consumption], skill_level)

		elsif @type == 'Buff'
			@skill = self.class.get_buff(@index)
			@new_skill = Buff.new(@skill[:name], @skill[:type], @skill[:turns], @skill[:defense_up], @skill[:attack_up], @skill[:mp_consumption], skill_level)

		elsif @type == 'Support'
			@skill = self.class.get_support(@index)
			@new_skill = Support.new(@skill[:name], @skill[:type], @skill[:hp_regen], @skill[:mp_regen], @skill[:mp_consumption], skill_level)

		else

		end

		return @new_skill
	end

	def use_random_skill target

		@target = target

		@mob_skills = [
			{ type: "Attack", index: 1, level: 1},
			{ type: "Attack", index: 2, level: 1},
			{ type: "Attack", index: 3, level: 1}
		]

		@skill_attributes = @mob_skills[1]

		@skill = build_skill("Attack", 1, 2)

#------------------

	if @skill.type == 'Attack'

			if self.current_mp < @skill.mp_consumption
				@skill = "NotEnoughMP"
			else
				self.current_mp -= @skill.mp_consumption

				@target.current_hp -= @skill.dmg if @target.current_hp > 0
				@target.current_hp = 0 if @target.current_hp < 0
			end

		elsif skill.type =='Buff'

			if current_mp < @skill.mp_consumption
				@skill = "NotEnoughMP"
			else

			end

		elsif skill.type =='Support'

			if self.current_mp < @skill.mp_consumption
				@skill = "NotEnoughMP"
			else
				self.current_mp -= @skill.mp_consumption

				self.current_hp += @skill.added_hp
				self.current_hp = self.max_hp if self.current_hp > self.max_hp

				self.current_mp += @skill.added_mp
				self.current_mp = self.max_mp if self.current_mp > self.max_mp
			end

		end

		if @skill != "NotEnoughMP"

			target.save
			self.save
			
			skill_hash = @skill.attributes

				target_name = @target.name
				caster_name = self.species.name

				target_type = "Character"
				caster_type = "Mob"

			FightTurn.create( maker_id: self.id, maker_type: caster_type, maker_name: caster_name,
									target_id: target.id, target_type: target_type, target_name: target_name,
									fight_type: "MobBattle", fight_id: self.mob_battle_id, 
									serialized_object: skill_hash.to_json
									)
		end


		return @skill


#------------------


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

	class Buff < Skill
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


	#------------------------------------------

end
