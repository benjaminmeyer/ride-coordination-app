class User < ActiveRecord::Base
	
	has_secure_password
	
	has_many :members
	has_many :organizations, :through => :members
	
	has_many :passengers
	has_many :rides, :through => :passengers
end
