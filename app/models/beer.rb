class Beer < ActiveRecord::Base

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true

  has_many :liked_users, through: :beer_like_relationships, source: :user
  has_many :beer_like_relationships, dependent: :destroy


  def self.all_beers
  	beer_array = []
  	Beer.all.each do |beer|
  		beer_array.push (beer.name+ " - Beer")
  	end
  	return beer_array
  end
end