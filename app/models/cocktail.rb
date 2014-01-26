class Cocktail < ActiveRecord::Base
  def self.all_cocktails
  	cocktail_array = []
  	Cocktail.all.each do |cocktail|
  		cocktail_array.push (cocktail.name+ " - Cocktail")
  	end
  	return cocktail_array
  end
end
