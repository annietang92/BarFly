class BeersController < ApplicationController
	before_action :signed_in_user,
                only: [:show, :create]
	
	def show
		@beer = Beer.find(params[:id])
	end

	def create
		@cocktail = Cocktail.new
		@venue = Venue.new
		@user = current_user
		@beer = Beer.new(beer_params)
		if @beer.save
			@drink = current_user.drinks.new
			@drink.name = @beer.name
			@drink.type = "Beer"
			@drink.drink_id = @beer.id
			@drink.comment = current_user.name.to_s + " just created a new beer!"
			if @drink.save
				flash.now[:success] = "New drink recorded! You can add a venue for your drink, or skip this step."
				render 'venues/new'
			else
				flash.now[:error] = "Something went wrong, please try again."
				render 'drinks/new'
			end
		else
			render 'drinks/new'
		end
	end
	private
	def beer_params
      params.require(:beer).permit(:name, :description, :brewed_by, :style, :abv, :ibu, :is_organic)
    end
end