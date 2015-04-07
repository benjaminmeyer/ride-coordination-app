class CreateRides < ActiveRecord::Migration
  def up
    create_table :rides do |t|
		t.integer "num_passengers"
		t.boolean "deleted", :default => false
    	t.timestamps
    end
  end
	
	def down
		drop_table :rides
	end
end
