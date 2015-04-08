class CreatePassengers < ActiveRecord::Migration
  def up
    create_table :passengers do |t|
		t.references :user
		t.references :ride
		t.string "role", :limit => 25
		t.boolean "deleted", :default => false
      t.timestamps
    end
	  
	add_index :passengers, ["user_id", "ride_id"]
  end
	
	def down
		drop_table :passengers
	end
end
