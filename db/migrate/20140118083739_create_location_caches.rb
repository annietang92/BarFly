class CreateLocationCaches < ActiveRecord::Migration
  def change
    create_table :location_caches do |t|
      t.text :text	
      t.timestamps
    end
  end
end
