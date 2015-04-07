class CreateOrganizations < ActiveRecord::Migration
  def up
    create_table :organizations do |t|
		t.string "name", :limit =>60
		t.string "semester", :limit => 25
		t.integer "year"
		t.boolean "deleted", :default => false
      t.timestamps
    end
  end
	
	def down
		drop_table :organizations
	end
end
