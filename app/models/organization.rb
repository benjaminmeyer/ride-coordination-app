class Organization < ActiveRecord::Base
	
	has_many :events
	
	has_many :members
	has_many :users, :through => :members
	
	scope :orgActive, lambda {where(:organizations.deleted => 0)}
	#scope :byuser, lambda {|user|
	#	where (:user_id => user)
	#}
	
end
