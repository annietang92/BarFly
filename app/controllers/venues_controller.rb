class VenuesController < ApplicationController

	def show
		@venue = Venue.find(params[:id])
	end

	def new
		@venue = Venue.new
		client = Foursquare2::Client.new(:client_id => '4IEC2TEEXYZBNXI4Z0XWKOPCXPTL54WIYGSL20IRJVOH41QT', :client_secret => 'U1W5VEBHWP4I020DJL1HQ14MTRCQAMMDKH554VTYKUG4BEGF')
		logger.info "ASHDALKSJHDLASKJHDA"
		@top_venues = client.search_venues(:near => current_user.location, categoryId: '4bf58dd8d48988d116941735').groups[0].items
		logger.info @top_venues.count

		if !@drink.nil?
			@user=current_user
		else
			flash[:error] = "Please record a drink first"
			redirect_to new_drink_path
		end
	end

	def search
		client = Foursquare2::Client.new(:client_id => '4IEC2TEEXYZBNXI4Z0XWKOPCXPTL54WIYGSL20IRJVOH41QT', :client_secret => 'U1W5VEBHWP4I020DJL1HQ14MTRCQAMMDKH554VTYKUG4BEGF')
		@top_venues = client.search_venues(:near => current_user.location, categoryId: '4bf58dd8d48988d116941735', limit: 20).groups[0].items
		@venue = Venue.new(venue_params)
		if @venue.name === "" || @venue.name.nil?
			@drink = Drink.find(@venue.drink_id)
			flash.now[:error] = "Must input a venue name!"
			render 'new'
			return
		end
		@drink = Drink.find(@venue.drink_id)
		@venues = client.search_venues(:near => @venue.city, :query => @venue.name).groups[0].items
		# @venues = client.search_venues(:near => @venue.city, :query => @venue.name).groups[0].items.paginate(page: params[:page], :per_page => 8)
		render 'new'
	end

	def create
		@venue = Venue.new(venue_params)
		@relationship = DrinkVenueRelationship.new
		@relationship.drink_id = @venue.drink_id
		if !Venue.find_by(foursquare_id: @venue.foursquare_id).nil?
			venue = Venue.find_by(foursquare_id: @venue.foursquare_id)
			checkins = venue.checkins + 1
			venue.update_attribute(:checkins, checkins)
			@relationship.venue_id = Venue.find_by(foursquare_id: @venue.foursquare_id).id
			@relationship.save
			redirect_to root_path
			return
		end
		if @venue.save 
			@relationship.venue_id = @venue.id
			@relationship.save
			redirect_to root_path
		else
			redirect_to current_user
		end
	end

	private

    def venue_params
      params.require(:venue).permit(:name, :foursquare_id, :lat, :long, :address, :city, :state, :zip, :phone, :ll, :description, :url, :hours, :picture, :drink_id, :likes, :checkins)
    end
end
