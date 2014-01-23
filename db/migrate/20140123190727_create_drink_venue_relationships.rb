class CreateDrinkVenueRelationships < ActiveRecord::Migration
  def change
    create_table :drink_venue_relationships do |t|

      t.integer :drink_id
      t.integer :venue_id

      t.timestamps
    end
    add_index :drink_venue_relationships, :drink_id
    add_index :drink_venue_relationships, :venue_id
    add_index :drink_venue_relationships, [:drink_id, :venue_id], unique: true
  end
end
