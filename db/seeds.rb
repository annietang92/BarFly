# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

LocationCache.delete_all
location_array = []
open(File.open(File.join(Rails.root, '/SeedData/US/US.txt'))) do |file|
	file.read.each_line do |line|
		line_array = line.split("\t")
		city = line_array[2]
		state = line_array[4]
		concat_location = city + ", " + state
		if !location_array.include? concat_location
			location_array.push(concat_location)
		end
	end
end
LocationCache.create(text: location_array.to_s)


Beer.delete_all
brewery_db = BreweryDB::Client.new do |config|
	config.api_key = '20da4cd59c6e41f4ad0850dfa4e1cf7d'
end
(1..2).each do |i| 
	brewery_db.beers.all(styleId: i.to_s).each do |beer|
		temp = Beer.new
		temp.name = beer.name
		if !beer.labels.nil?
			temp.img_icon = beer.labels.icon
			temp.img_med = beer.labels.medium
			temp.img_lg = beer.labels.large
		end
		if !beer.style.nil?
			temp.style = beer.style.name
			temp.style_type = beer.style.category.name
		end
		temp.description = beer.description
		temp.abv = beer.abv
		temp.ibu = beer.ibu
		temp.is_organic = beer.is_organic
		if !beer.available.nil?
			temp.availability = beer.available.name
		end
		if !beer.glass.nil?
			temp.serving = beer.glass.name
		end
		temp.variations = beer.beerVariation.to_s
		temp.beer_id = beer.id
		temp.save
	end
end
