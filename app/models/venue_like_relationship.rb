class VenueLikeRelationship < ActiveRecord::Base
	belongs_to :venue, class_name: "Venue" 
	belongs_to :user, class_name: "User"

	validates :venue_id, presence: true
	validates :user_id, presence: true
end
