class StaticPagesController < ApplicationController
	def index
		if signed_in?
			@user = current_user
			@drinks = current_user.drinks
			@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end
end
