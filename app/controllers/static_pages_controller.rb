class StaticPagesController < ApplicationController
	def index
		if signed_in?
			@user = current_user
			@drinks = current_user.drinks
			@feed_items = current_user.feed.paginate(page: params[:page], :per_page => 8)
		end
	end
end
