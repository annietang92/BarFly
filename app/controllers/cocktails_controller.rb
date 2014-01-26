class CocktailsController < ApplicationController
	def show
		@cocktail = Cocktail.find(params[:id])
	end
end
