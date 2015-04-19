class Organization < ActiveRecord::Base
	
	has_many :events
	
	has_many :members
	has_many :users, :through => :members
	
	#make sure name is inserted into database
	validates_presence_of :name
	validates_length_of :name, :maximum => 255
	
	scope :orgActive, lambda {where(:organizations.deleted => 0)}
	#scope :byuser, lambda {|user|
	#	where (:user_id => user)
	#}
	
end
