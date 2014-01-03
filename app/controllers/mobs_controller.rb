class MobsController < ApplicationController


	def show
		@mob = Mob.find(params[:id])

		@mob_skills = [
			{ type: "Attack", index: 1, level: 1},
			{ type: "Attack", index: 2, level: 1},
			{ type: "Attack", index: 3, level: 1}
		]

		@skills =[]

		@mob_skills.each {|skill| @skills << @mob.build_skill(skill[:type], skill[:index], skill[:level]) }
	end



end
