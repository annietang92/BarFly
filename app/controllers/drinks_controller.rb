class DrinksController < ApplicationController
	def new
		@user = current_user
		@drink = Drink.new
	end
end
