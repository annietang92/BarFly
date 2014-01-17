brewery_db = BreweryDB::Client.new do |config|
  config.api_key = '20da4cd59c6e41f4ad0850dfa4e1cf7d'
end

Beer.delete_all

brewery_db.beers.all(styleId: '1').each do |beer|
	temp = Beer.new
	temp.name = beer.name
	temp.brewed_by = beer.breweries.first
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

# beers = brewery_db.beers.all(abv: '5.5').each do |beer|
# 	Beer.create()
# end



# open(File.open(File.join(Rails.root, '/SeedData/US/US.txt'))) do |file|
# 	file.read.each_line do |line|
# 		line_array = line.split("\t")
# 		city = line_array[2]
# 		state = line_array[4]
# 		latitude = line_array[9]
# 		longitude = line_array[10]
# 		Location.find_or_create_by(city: city, state: state) do |d|
# 			d.city = city
# 			d.state = state
# 			d.latitude = latitude
# 			d.longitude = longitude
# 		end
# 	end
# end