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