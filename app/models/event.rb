class Event < ActiveRecord::Base
	
	belongs_to :organization
	has_many :rides
	
	scope :eventActive, lambda {where(:events.deleted => 0)}
	
end
