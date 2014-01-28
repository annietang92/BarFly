class StaticPagesController < ApplicationController
	require 'will_paginate/array'

	def index
		if signed_in?
			@top_venues = Venue.top_venues_around(current_user).take(10)
			@top_drinks = Drink.where(location: current_user.location).take(10)
			@dashboard = true
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
		@top = true
		@top_beers = Beer.all(:order => "likes DESC").take(30)
		@top_cocktails = Cocktail.where(iba: "Y").reverse.take(30)
		@user_tried = current_user.drinks.pluck(:name)
	end

	def discover
		@discover = true
		@top_venues = Venue.all.where(location: current_user.location(:order => "likes DESC")).take(40)
	end
end