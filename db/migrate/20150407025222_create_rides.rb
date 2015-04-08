class CreateRides < ActiveRecord::Migration
  def up
    create_table :rides do |t|
		t.references :event
		# user is the driver of the car
		# t.references :user
		t.integer "num_passengers"
		t.boolean "deleted", :default => false
    	t.timestamps
    end
	  
	#add_index("rides", "user_id")
	add_index("rides", "event_id")
  end
	
	def down
		drop_table :rides
	end
end
