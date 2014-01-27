class RenameFeedInUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :feed
  	add_column :users, :feed_preference, :string
  end
end
