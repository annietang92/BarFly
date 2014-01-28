class BeerLikeRelationship < ActiveRecord::Base
	belongs_to :beer, class_name: "Beer" 
	belongs_to :user, class_name: "User"

	validates :beer_id, presence: true
	validates :user_id, presence: true
end
