class AddNewAndRecommendationsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :recommendations, :string
  	add_column :users, :new, :string
  end
end
