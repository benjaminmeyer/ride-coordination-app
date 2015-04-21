class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
		t.column "first_name", :string, :limit => 25
		t.string "last_name", :limit => 25
		t.string "email"
		t.string "password_digest"
		t.integer "car_passengers"
		t.boolean "deleted", :default => false
    	t.timestamps
    end
  end
	
	def down
		drop_table :users
	end
end
