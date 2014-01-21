class Drink < ActiveRecord::Base
	self.inheritance_column = nil
	belongs_to :user
  	validates :name,  presence: true
  	validates :type, presence: true
  	validates :drink_id, presence: true
  	validates :user_id, presence: true
end
