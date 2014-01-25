class RecommendationsController < ApplicationController
	def index
		if current_user.recommendations.nil?
		else
			redirect_to 'show'
		end
	end

	def show
	end
end
