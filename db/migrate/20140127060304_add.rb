class Add < ActiveRecord::Migration
  def change
  	add_column :users, :feed, :string
  end
end
