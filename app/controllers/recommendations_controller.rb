class RecommendationsController < ApplicationController
	def index
		@drinks = current_user.drinks
		@beers = current_user.beers
		@cocktails = current_user.cocktails
		@beer_types = current_user.beer_types
		@cocktail_types = current_user.cocktail_types

		@similar_cocktails = []
		@cocktail_types.each do |ct|
			Cocktail.all.where(primary: ct).each do |c|
				@similar_cocktails.push(c) unless @cocktails.include?(c)
			end
		end
	end
end

