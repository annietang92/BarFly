class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
    	t.string :name
    	t.string :address
    	t.string :city
    	t.string :state
    	t.string :zip
    	t.string :phone
    	t.string :ll
    	t.text :description
    	t.string :url
    	t.string :hours
    	t.string :picture
    	t.integer :likes
    	t.integer :checkins
      t.timestamps
    end
  end
end
