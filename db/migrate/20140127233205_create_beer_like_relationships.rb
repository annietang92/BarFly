class CreateBeerLikeRelationships < ActiveRecord::Migration
  def change
    create_table :beer_like_relationships do |t|
	  t.integer :user_id
      t.integer :beer_id
      t.timestamps
    end
  	add_index :beer_like_relationships, :user_id
    add_index :beer_like_relationships, :beer_id
    add_index :beer_like_relationships, [:user_id, :beer_id], unique: true
  end
end