class DrinkVenueRelationship < ActiveRecord::Base
	belongs_to :drink, class_name: "Drink" 
	belongs_to :venue, class_name "Venue"

	validates :drink_id, presence: true
	validates :note_id, presence: true
end
