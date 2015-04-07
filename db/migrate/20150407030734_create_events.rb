class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
		t.string "name"
		t.string "address"
		t.date "date"
		t.time "start_time"
		t.time "end_time"
		t.boolean "deleted", :default => false
      t.timestamps
    end
  end
	
	def down
		drop_table :events
	end
end
