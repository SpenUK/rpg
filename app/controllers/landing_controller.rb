class LandingController < ApplicationController

	def index

		@top_20 = Character.find(:all, order: "level, exp desc", limit: 20).reverse

	end
end
