# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.delete_all

# app = FbGraph::Application.new('793181580695859', :secret => 'f7694cc315f760524d59b199002c4c02')

# users = []
# (1..10).each do |user|
# 	user = app.test_user!(:installed => true, :permissions => :read_stream)
# 	users.push(user)
# end

# users.each do |auth|
# 	users.each do |u|
# 		if auth != u
# 			if auth.friends.empty? && u.friends.empty?
# 				auth.friend!(u)
# 				p "got here"
# 			else
# 				exisiting_friend = false
# 				auth.friends.each do |friend|
# 					if friend.identifier == u.identifier
# 						exisiting_friend = true
# 					end
# # 				end 
# # 				if !exisiting_friend
# # 					auth.friend!(u)
# # 				end
# # 			end
# # 		end
# # 	end
# # 	user = User.new
# # 	user.name = "TestUser" + auth.identifier.to_s
# # 	user.email = auth.identifier.to_s+"@test.com"
# # 	user.password = "testtest"
# # 	user.password_confirmation = "testtest"
# # 	user.uid = auth.identifier
# # 	user.oauth_token = auth.access_token
# # 	user.provider = "facebook"
# # 	user.location = "Cambridge, MA"
# # 	user.save!
# # end

Cocktail.delete_all
open(File.open(File.join(Rails.root, '/SeedData/Cocktails.txt'))) do |file|
	file.read.each_line do |line|
		line_array = line.gsub("\n", "").split("\t")
		cocktail = Cocktail.new
		if !line_array[0].nil?
			cocktail.name = line_array[0].squish
		end
		if !line_array[1].nil?
			cocktail.primary = line_array[1].squish
		end
		if !line_array[2].nil?
			cocktail.iba = line_array[2].squish
		end
		cocktail.alcohols = line_array[3]
		cocktail.served = line_array[4]
		cocktail.glass = line_array[5]
		cocktail.ingredients = line_array[6]
		cocktail.instructions = line_array[7]
		cocktail.description = line_array[8]
		cocktail.image = line_array[9]
		if !line_array[10].nil?
			cocktail.likes = Integer(line_array[10])
		end
		if Cocktail.find_by(name: cocktail.name).nil?
			cocktail.save
		end
	end
end

# LocationCache.delete_all
# location_array = []
# open(File.open(File.join(Rails.root, '/SeedData/US/US.txt'))) do |file|
# 	file.read.each_line do |line|
# 		line_array = line.split("\t")
# 		city = line_array[2]
# 		state = line_array[4]
# 		concat_location = city + ", " + state
# 		if !location_array.include? concat_location
# 			location_array.push(concat_location)
# 		end
# 	end
# end
# LocationCache.create(text: location_array.to_s)

# Beer.delete_all
brewery_db = BreweryDB::Client.new do |config|
	config.api_key = '20da4cd59c6e41f4ad0850dfa4e1cf7d'
end

(35..99).each do |i| 
	brewery_db.beers.all(styleId: i.to_s, :withBreweries => 'Y').each do |beer|
		next if beer.labels.nil?
		next if beer.style.nil?
		temp = Beer.new
		temp.name = beer.name
		temp.brewed_by = beer.breweries.first.name
		temp.img_icon = beer.labels.icon
		temp.img_med = beer.labels.medium
		temp.img_lg = beer.labels.large
		temp.style = beer.style.name
		temp.style_type = beer.style.category.name
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
		if !beer.beerVariation.nil?
			temp.variations = beer.beerVariation.name
		end
		temp.beer_id = beer.id
		temp.save
	end
end