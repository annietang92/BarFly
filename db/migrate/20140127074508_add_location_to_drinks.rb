class AddLocationToDrinks < ActiveRecord::Migration
  def change
  	add_column :drinks, :location, :string
  end
end
