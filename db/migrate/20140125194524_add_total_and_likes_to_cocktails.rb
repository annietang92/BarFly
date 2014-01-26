class AddTotalAndLikesToCocktails < ActiveRecord::Migration
  def change
  	add_column :cocktails, :total, :int
  	add_column :cocktails, :likes, :int
  end
end
