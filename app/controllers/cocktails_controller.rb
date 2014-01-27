class CocktailsController < ApplicationController
	before_action :signed_in_user,
                only: [:show]
	def show
		@cocktail = Cocktail.find(params[:id])
		@feed_items = Drink.all.where(name: @cocktail.name).paginate(page: params[:page], :per_page => 20)
	end

	def create
		@beer = Beer.new
		@venue = Venue.new
		@user = current_user
		@cocktail = Cocktail.new(cocktail_params)
		if @cocktail.save
			@drink = current_user.drinks.new
			@drink.name = @cocktail.name
			@drink.type = "Cocktail"
			@drink.drink_id = @cocktail.id
			@drink.comment = current_user.name.to_s + " just created a new cocktail!"
			if @drink.save
				flash.now[:success] = "New drink recorded! You can add a venue for your drink, or skip this step."
				render 'venues/new'
			else
				flash.now[:error] = "Something went wrong, please try again."
				@cocktail_active = "yes"
				render 'drinks/new'
			end
		else
			@cocktail_active = "yes"
			render 'drinks/new'
		end
	end
	private
	def cocktail_params
      params.require(:cocktail).permit(:name, :description, :primary, :alcohols, :served, :glass, :ingredients, :instructions, :iba)
    end
end