class Ride < ActiveRecord::Base
	
	belongs_to :event
	
	has_many :passengers
	has_many :users, :through => :passengers
	
end
