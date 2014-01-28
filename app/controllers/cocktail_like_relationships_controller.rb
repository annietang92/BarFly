class CocktailLikeRelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @cocktail = Cocktail.find(params[:cocktail_like_relationship][:cocktail_id])
    current_user.like_cocktail!(@cocktail)
    redirect_to @cocktail
  end

  def destroy
    @cocktail = CocktailLikeRelationship.find(params[:id]).cocktail
    current_user.unlike_cocktail!(@cocktail)
    redirect_to @cocktail
  end
end
