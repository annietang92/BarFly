class Venue < ActiveRecord::Base
	attr_accessor :drink_id
	has_many :drinks, through: :drink_venue_relationships
	has_many :drink_venue_relationships, dependent: :destroy
end
