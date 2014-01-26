class BeersController < ApplicationController
	def show
		@beer = Beer.find(params[:id])
	end
end
