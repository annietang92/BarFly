class StaticPagesController < ApplicationController
	def index
		if signed_in?
			@user = current_user
			@drinks = current_user.drinks
		end
	end
end
