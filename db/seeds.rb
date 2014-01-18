# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Location.delete_all
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

Location.first.destroy
Location.first.destroy