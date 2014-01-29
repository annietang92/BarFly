class DrinksController < ApplicationController
	before_action :signed_in_user
	
	def new
		@beer = Beer.new
		@cocktail = Cocktail.new
		@feed_items = current_user.feed.paginate(page: params[:page], :per_page => 30)
		@user = current_user
		@drink = Drink.new
		@beers = Beer.all_beers
		@cocktails = Cocktail.all_cocktails
		@all_drinks = @beers + @cocktails
	end

	def create
		if !LocationCache.is_valid_location(current_user.location)
			flash[:error] = "Please update with a valid location"
			redirect_to edit_user_path(current_user)
			return
		end
		@fly_status_orig = current_user.fly_status
		@feed_items = current_user.feed.paginate(page: params[:page], :per_page => 30)
		@new_drink = Drink.new
		@user = current_user
		@drink = current_user.drinks.new(drink_params)
		drink_name_type = @drink.name.split(" \- ")
		@drink.name = drink_name_type[0]
		@drink.type = drink_name_type[1]
		@drink.location = @user.location
		@venue = Venue.new
		if @drink.type === "Beer"
			if !Beer.find_by(name: @drink.name).nil?
				@drink.drink_id = Beer.find_by(name: @drink.name).id
			else
				flash.now[:error] = "We have no record of that drink! #{ActionController::Base.helpers.link_to "Would you like to add it?", '/drinks/new'}".html_safe
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
			flash.now[:success] = "New drink recorded! You can add a venue, #{ActionController::Base.helpers.link_to "or skip this step.", '/'}".html_safe
			@updated_fly_status = current_user.fly_status
			if @fly_status_orig != @updated_fly_status
				message = "fly status update"
				flash.now[:fly_status] = message
			end
			@venue.city = current_user.location
			client = Foursquare2::Client.new(:client_id => '4IEC2TEEXYZBNXI4Z0XWKOPCXPTL54WIYGSL20IRJVOH41QT', :client_secret => 'U1W5VEBHWP4I020DJL1HQ14MTRCQAMMDKH554VTYKUG4BEGF')
			if !current_user.location.nil? || current_user.location != ""
				@top_venues = client.search_venues(:near => @user.location, categoryId: '4bf58dd8d48988d116941735', limit: 10).groups[0].items
			end
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