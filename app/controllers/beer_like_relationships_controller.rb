class BeerLikeRelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @beer = Beer.find(params[:beer_like_relationship][:beer_id])
    current_user.like_beer!(@beer)
    redirect_to @beer
  end

  def destroy
    @beer = BeerLikeRelationship.find(params[:id]).beer
    current_user.unlike_beer!(@beer)
    redirect_to @beer
  end
end
