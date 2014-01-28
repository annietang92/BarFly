class Drink < ActiveRecord::Base
	self.inheritance_column = nil
	belongs_to :user
  	validates :name,  presence: true
  	validates :type, presence: true
  	validates :drink_id, presence: true
  	validates :user_id, presence: true

  	default_scope -> { order('updated_at DESC') }

  	has_one :drink_venue_relationship, dependent: :destroy
  	has_one :venue, through: :drink_venue_relationship, source: :venue

  	def self.from_users_followed_by(user)
	    followed_user_ids = "SELECT followed_id FROM relationships
	                         WHERE follower_id = :user_id"
	    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
	          user_id: user.id)
	  end

    def self.top_drinks_around(user)
      drinks = Drink.where(location: user.location)
      unique_drinks = []
      drinks.each do |drink|
        if !unique_drinks.include?(drink.name)
          unique_drinks.push(drink.name)
        end
      end
      return unique_drinks
    end
end
