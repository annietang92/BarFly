class Location < ActiveRecord::Base

  def concat_location
    return self.city + ", " + self.state
  end

  def self.location_array
  	location_array = []
  	Location.all.each do |city|
  		location_array.push(city.concat_location)
  	end
  	return location_array
  end
end
