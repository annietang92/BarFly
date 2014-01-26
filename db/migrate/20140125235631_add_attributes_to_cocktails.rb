class AddAttributesToCocktails < ActiveRecord::Migration
  def change
  	add_column :cocktails, :alcohols, :string
  	add_column :cocktails, :served, :string
  	add_column :cocktails, :glass, :string
  	add_column :cocktails, :ingredients, :string
  	add_column :cocktails, :instructions, :text
  	add_column :cocktails, :description, :text
  	add_column :cocktails, :image, :string
  end
end
