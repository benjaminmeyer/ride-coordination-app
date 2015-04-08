class CreateMembers < ActiveRecord::Migration
  def up
    create_table :members do |t|
		t.references :user
		t.references :organization
		t.string "role", :limit => 25
		t.boolean "deleted", :default => false
      t.timestamps
    end
	  
	add_index :members, ["user_id", "organization_id"]
  end
	
	def down
		drop_table :members
	end
end
