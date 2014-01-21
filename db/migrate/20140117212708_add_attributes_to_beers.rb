class AddAttributesToBeers < ActiveRecord::Migration
  def change
  	add_column :beers, :name, :text
  	add_column :beers, :brewed_by, :text
  	add_column :beers, :img_icon, :text
  	add_column :beers, :img_med, :text
  	add_column :beers, :img_lg, :text
  	add_column :beers, :style, :text
  	add_column :beers, :style_type, :text
  	add_column :beers, :description, :text
  	add_column :beers, :abv, :text
  	add_column :beers, :ibu, :text
  	add_column :beers, :is_organic, :text
  	add_column :beers, :likes, :integer
  	add_column :beers, :total, :integer
  	add_column :beers, :unique, :integer
  	add_column :beers, :monthly, :integer
  end
end
