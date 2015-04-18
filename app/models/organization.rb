class Organization < ActiveRecord::Base
	
	has_many :events
	
	has_many :members
	has_many :users, :through => :members
	
	scope :active, lambda {where(:deleted => 0)}
	#scope :byuser, lambda {|user|
	#	where (:user_id => user)
	#}
	
end
