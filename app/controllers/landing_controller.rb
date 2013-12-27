class LandingController < ApplicationController

	def index

		@offset = params[:off] || 0

		@top_20 = Character.find(:all, order: "level desc, exp desc", offset: @offset, limit: 20)

	end
end
