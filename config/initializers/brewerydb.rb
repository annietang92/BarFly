brewery_db = BreweryDB::Client.new do |config|
  config.api_key = '20da4cd59c6e41f4ad0850dfa4e1cf7d'
end

# (90..160).each do |i| 
# 	brewery_db.beers.all(styleId: i.to_s).each do |beer|
# 		temp = Beer.new
# 		temp.name = beer.name
# 		if !beer.labels.nil?
# 			temp.img_icon = beer.labels.icon
# 			temp.img_med = beer.labels.medium
# 			temp.img_lg = beer.labels.large
# 		end
# 		if !beer.style.nil?
# 			temp.style = beer.style.name
# 			temp.style_type = beer.style.category.name
# 		end
# 		temp.description = beer.description
# 		temp.abv = beer.abv
# 		temp.ibu = beer.ibu
# 		temp.is_organic = beer.is_organic
# 		if !beer.available.nil?
# 			temp.availability = beer.available.name
# 		end
# 		if !beer.glass.nil?
# 			temp.serving = beer.glass.name
# 		end
# 		temp.variations = beer.beerVariation.to_s
# 		temp.beer_id = beer.id
# 		temp.save
# 	end
# end
