class VenueLikeRelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @venue = Venue.find(params[:venue_like_relationship][:venue_id])
    current_user.like_venue!(@venue)
    redirect_to @venue
  end

  def destroy
    @venue = VenueLikeRelationship.find(params[:id]).venue
    current_user.unlike_venue!(@venue)
    redirect_to @venue
  end
end
