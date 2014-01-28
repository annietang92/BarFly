class CreateCocktailLikeRelationships < ActiveRecord::Migration
  def change
    create_table :cocktail_like_relationships do |t|
      t.integer :user_id
      t.integer :cocktail_id
      t.timestamps
    end
    add_index :cocktail_like_relationships, :user_id
    add_index :cocktail_like_relationships, :cocktail_id
    add_index :cocktail_like_relationships, [:user_id, :cocktail_id], unique: true
  end
end

