class Beer < ActiveRecord::Base
  def self.all_beers
  	beer_array = []
  	Beer.all.each do |beer|
  		beer_array.push (beer.name)
  	end
  	return beer_array
  end
end