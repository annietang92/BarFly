class Venue < ActiveRecord::Base
	attr_accessor :drink_id
	has_many :drinks, through: :drink_venue_relationships
	has_many :drink_venue_relationships, dependent: :destroy

	has_many :liked_users, through: :venue_like_relationships, source: :user
  	has_many :venue_like_relationships, dependent: :destroy
end
