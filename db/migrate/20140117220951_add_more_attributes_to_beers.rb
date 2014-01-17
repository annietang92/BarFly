class AddMoreAttributesToBeers < ActiveRecord::Migration
  def change
  	add_column :beers, :availability, :string
  	add_column :beers, :serving, :string
  	add_column :beers, :variations, :string
  	add_column :beers, :beer_id, :string
  end
end
