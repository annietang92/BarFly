class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.name :string
      t.description :text
      t.timestamps
    end
  end
end
