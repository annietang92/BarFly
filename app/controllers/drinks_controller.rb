class DrinksController < ApplicationController
	def new
		@user = current_user
		@drink = Drink.new
		@beers = Beer.all_beers
	end

	def create
	end
end