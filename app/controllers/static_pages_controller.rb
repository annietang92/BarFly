class StaticPagesController < ApplicationController
	def index
		if signed_in?
			all_drinks = Cocktail.all_cocktails + Beer.all_beers
			@all_drinks = all_drinks.sort
			@user = current_user
			@new_drink = Drink.new
			@drinks = current_user.drinks
			@feed_items = current_user.feed.paginate(page: params[:page], :per_page => 8)
		end
	end
end