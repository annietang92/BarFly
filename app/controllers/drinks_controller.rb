class DrinksController < ApplicationController
	def new
		@user = current_user
		@drink = Drink.new
		@beers = Beer.all_beers
		@cocktails = Cocktail.all_cocktails
		@all_drinks = @beers + @cocktails
	end

	def create
		@user = current_user
		@drink = current_user.drinks.new(drink_params)
		@venue = Venue.new
		if @drink.type === "Beer"
			if !Beer.find_by(name: @drink.name).nil?
				@drink.drink_id = Beer.find_by(name: @drink.name).id
			else
				flash[:error] = "We have no record of that drink, please add it as a new drink!"
				render 'new'
				return
			end
		else
			if !Cocktail.find_by(name: @drink.name).nil?
				@drink.drink_id = Cocktail.find_by(name: @drink.name).id
			else
				flash[:error] = "We have no record of that drink, please add it as a new drink!"
				render 'new'
				return
			end
		end
		if @drink.save
			flash[:success] = "New drink recorded! You can add a venue for your drink, or skip this step."
			render 'venues/new'
		else
			render 'new'
		end
	end
	def destroy
		@drink = Drink.all.find(params[:id])
	    @drink.destroy
	    redirect_to root_path
	end

	private

    def drink_params
      params.require(:drink).permit(:name, :type, :comment)
    end

    # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @drink = current_user.drinks.find_by_id(params[:id])
      redirect_to root_path if @drink.nil?
    end
end