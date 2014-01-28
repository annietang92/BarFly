class CreateVenueLikeRelationships < ActiveRecord::Migration
  def change
    create_table :venue_like_relationships do |t|
      t.integer :user_id
      t.integer :venue_id
      t.timestamps
    end
    add_index :venue_like_relationships, :user_id
    add_index :venue_like_relationships, :venue_id
    add_index :venue_like_relationships, [:user_id, :venue_id], unique: true
  end
end