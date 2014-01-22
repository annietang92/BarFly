class FacebookController < ApplicationController
	require 'will_paginate/array'
	def index
		@user = FbGraph::User.fetch(current_user.uid, :access_token => current_user.oauth_token)
		@facebook = @user.friends.paginate(page: params[:page], :per_page => 50)
	end
end
