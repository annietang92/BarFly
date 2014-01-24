class ChangeVenueAttributes < ActiveRecord::Migration
  def change
  	add_column :venues, :lat, :float
  	add_column :venues, :lng, :float
  	add_column :venues, :foursquare_id, :string
  	remove_column :venues, :ll
  end
end
