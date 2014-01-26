class DrinksController < ApplicationController
	def new
		@user = current_user
		@drink = Drink.new
		@beers = Beer.all_beers
		@cocktails = Cocktail.all_cocktails
		@all_drinks = @beers + @cocktails
	end

	def create
		@new_drink = Drink.new
		@user = current_user
		@drink = current_user.drinks.new(drink_params)
		drink_name_type = @drink.name.split(" \- ")
		@drink.name = drink_name_type[0]
		@drink.type = drink_name_type[1]
		@venue = Venue.new
		if @drink.type === "Beer"
			if !Beer.find_by(name: @drink.name).nil?
				@drink.drink_id = Beer.find_by(name: @drink.name).id
			else
				flash.now[:error] = "We have no record of that drink! Would you like to add it?"
				render 'static_pages/index'
				return
			end
		else
			if !Cocktail.find_by(name: @drink.name).nil?
				@drink.drink_id = Cocktail.find_by(name: @drink.name).id
			else
				flash.now[:error] = "We have no record of that drink! #{ActionController::Base.helpers.link_to "Would you like to add it?", '/drinks/new'}".html_safe
				render 'static_pages/index'
				return
			end
		end
		if @drink.save
			flash[:success] = "New drink recorded! You can add a venue for your drink, or skip this step."
			render 'venues/new'
		else
			render 'static_pages/index'
		end
	end
	def destroy
		@drink = Drink.all.find(params[:id])
	    @drink.destroy
	    redirect_to root_path
	end

	private

    def drink_params
      params.require(:drink).permit(:name, :comment)
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