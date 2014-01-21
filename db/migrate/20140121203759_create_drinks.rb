class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|

      t.string :name
      t.string :type
      t.integer :drink_id
      t.text :comment
      t.integer :likes
      t.integer :user_id

      t.timestamps
    end
  end
end
