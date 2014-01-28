class StaticPagesController < ApplicationController
	require 'will_paginate/array'

	def index
		@dashboard = true
		if signed_in?
			all_drinks = Cocktail.all_cocktails + Beer.all_beers
			@all_drinks = all_drinks.sort
			@user = current_user
			@new_drink = Drink.new
			@drinks = current_user.drinks

			if @user.feed_preference === "Friends"
				@feed_items = current_user.feed.paginate(page: params[:page], :per_page => 10)
			elsif @user.feed_preference === "All"
				@feed_items = current_user.feed_all.paginate(page: params[:page], :per_page => 10)
			else
				@feed_items = current_user.feed_local.paginate(page: params[:page], :per_page => 10)
			end
				
		end
	end

	def passport
		@passport = true
		@venues = current_user.venues.paginate(page: params[:page], :per_page => 48)
	end

	def top
		@top_beers = Beer.find(:all, :order => "likes").reverse
		@top_cocktails = Cocktail.find(:all, :order => "likes").reverse
		@user_tried = current_user.drinks.pluck(:name)
	end
end