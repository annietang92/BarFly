class LocationCache < ActiveRecord::Base

	def self.state_code(state)
		first_last = ['Kansas','Connecticut','Georgia','Hawaii','Iowa','Kentucky','Louisiana','Maine','Maryland','Pennsylvania','Virginia'] 
		if state.include?(' ')
			words = state.split
			abv = ''
			words.each do |w|
				abv = abv + w
			end
		elsif first_last.include?(state)
			abv = state.first + state.last
		elsif state === 'Alaska'
			abv = 'AK'
		elsif state === 'Arizona'
			abv = 'AZ'
		elsif state === 'Minnesota'
			abv = 'MN'
		elsif state === 'Mississippi'
			abv = 'MS'
		elsif state === 'Montana'
			abv = 'MT'
		elsif state === 'Nevada'
			abv = 'NV'
		elsif state === 'Tennessee'
			abv = 'TN'
		elsif state === 'Texas'
			abv = 'TX'
		else
			abv = state[0] + state[1]
		end
		return abv.upcase		
	end

	def self.is_valid_location(location)
		if LocationCache.first.text.include?(location)
			if location.include?(", ")
				return true
			end
		else
			return false
		end
	end
end
