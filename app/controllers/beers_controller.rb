class BeersController < ApplicationController
	before_action :signed_in_user,
                only: [:show, :create]
	
	def show
		@discover = true
		@beer = Beer.find(params[:id])
		@feed_items = Drink.all.where(name: @beer.name).paginate(page: params[:page], :per_page => 20)
	end

	def create
		@discover = true
		@cocktail = Cocktail.new
		@venue = Venue.new
		@user = current_user
		@beer = Beer.new(beer_params)
		if @beer.save
			@drink = current_user.drinks.new
			@drink.location = current_user.location
			@drink.name = @beer.name
			@drink.type = "Beer"
			@drink.drink_id = @beer.id
			@drink.comment = current_user.name.to_s + " just created a new beer!"
			if @drink.save
				@venue.city = current_user.location
				client = Foursquare2::Client.new(:api_version => '20120505', :client_id => '4IEC2TEEXYZBNXI4Z0XWKOPCXPTL54WIYGSL20IRJVOH41QT', :client_secret => 'U1W5VEBHWP4I020DJL1HQ14MTRCQAMMDKH554VTYKUG4BEGF')
				if !current_user.location.nil? || current_user.location != ""
					@top_venues = client.search_venues(:near => @user.location, categoryId: '4bf58dd8d48988d116941735', limit: 20).venues
				end
				flash.now[:success] = "New drink recorded! You can add a venue for your drink, or skip this step."
				render 'venues/new'
			else
				flash[:error] = "Something went wrong, please try again."
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