class DropLocationsTable < ActiveRecord::Migration
  def change
  	  def up
	    drop_table :locations
	  end

	  def down
	    raise ActiveRecord::IrreversibleMigration
	  end
  end
end
