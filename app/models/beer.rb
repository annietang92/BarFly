class Beer < ActiveRecord::Base

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true

  def self.all_beers
  	beer_array = []
  	Beer.all.each do |beer|
  		beer_array.push (beer.name+ " - Beer")
  	end
  	return beer_array
  end
end