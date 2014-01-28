class CocktailLikeRelationship < ActiveRecord::Base
	belongs_to :cocktail, class_name: "Cocktail" 
	belongs_to :user, class_name: "User"

	validates :cocktail_id, presence: true
	validates :user_id, presence: true
end
