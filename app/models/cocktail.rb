class Cocktail < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :primary, presence: true
  def self.all_cocktails
  	cocktail_array = []
  	Cocktail.all.each do |cocktail|
  		cocktail_array.push (cocktail.name+ " - Cocktail")
  	end
  	return cocktail_array
  end
end
