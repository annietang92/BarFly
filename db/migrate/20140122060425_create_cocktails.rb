class CreateCocktails < ActiveRecord::Migration
  def change
    create_table :cocktails do |t|
      t.string :name
      t.string :primary
      t.string :iba
      
      t.timestamps
    end
  end
end
