class Drink < ActiveRecord::Base
	belongs_to :user
  	validates :name,  presence: true
  	validates :type, presence: true
  	validates :drink_id, presence: true
  	validates :user_id, presence: true
end
