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
		@drink = current_user.drinks.new(user_params)
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
			flash[:success] = "New Drink Saved!"
			redirect_to root_path
		else
			render 'new'
		end
	end

	private

    def user_params
      params.require(:drink).permit(:name, :type, :comment)
    end

    # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
end