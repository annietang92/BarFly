class Venue < ActiveRecord::Base
	has_many :drinks, through: :drink_venue_relationships
	has_many :drink_venue_relationships, dependent: :destroy
end
