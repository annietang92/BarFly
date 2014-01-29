class Venue < ActiveRecord::Base
	attr_accessor :drink_id
	has_many :drinks, through: :drink_venue_relationships
	has_many :drink_venue_relationships, dependent: :destroy

	has_many :liked_users, through: :venue_like_relationships, source: :user
  	has_many :venue_like_relationships, dependent: :destroy

  	def self.top_venues_around(user)
  		if !user.location.nil?
  			userlocation = user.location.split(",")
  			city = userlocation[0].squish
  			state = userlocation[1].squish unless userlocation.count === 1
  			return Venue.where(city: city, state: state)
  		else
  			return []
  		end
  	end
end
