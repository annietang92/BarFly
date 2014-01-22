class AddAttributesToBeers < ActiveRecord::Migration
  def change
  	add_column :beers, :brewed_by, :string
  	add_column :beers, :img_icon, :string
  	add_column :beers, :img_med, :string
  	add_column :beers, :img_lg, :string
  	add_column :beers, :style, :string
  	add_column :beers, :style_type, :string
  	add_column :beers, :abv, :string
  	add_column :beers, :ibu, :string
  	add_column :beers, :is_organic, :string
  	add_column :beers, :likes, :integer
  	add_column :beers, :total, :integer
  	add_column :beers, :unique, :integer
  	add_column :beers, :monthly, :integer
  end
end
