class VenuesController < ApplicationController
	def new
		@venue = Venue.new
		if !@drink.nil?
			@user=current_user
		else
			flash[:error] = "Please record a drink first"
			redirect_to new_drink_path
		end
	end

	def search
		@venue = Venue.new(venue_params)
		client = Foursquare2::Client.new(:client_id => '4IEC2TEEXYZBNXI4Z0XWKOPCXPTL54WIYGSL20IRJVOH41QT', :client_secret => 'U1W5VEBHWP4I020DJL1HQ14MTRCQAMMDKH554VTYKUG4BEGF')
		@venues = client.search_venues(:near => @venue.city, :query => @venue.name).groups[0].items
		# @venues = client.search_venues(:near => @venue.city, :query => @venue.name).groups[0].items.paginate(page: params[:page], :per_page => 8)
		render 'new'
	end

	def save
	end

	def create
		@venue = Venue.new(venue_params)
	end

	private

    def venue_params
      params.require(:venue).permit(:name, :city)
    end
end
