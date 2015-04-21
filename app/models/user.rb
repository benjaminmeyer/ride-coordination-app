# Name: Ben Meyer
# Course: CSC 415
# Semester: Spring 2015
# Instructor: Dr. Pulimood 
# Project name: CooRIDEinate
# Description: Allows for members of an organization to coordinate rides to a common place
# Filename: user.rb 
# Description: Defines relations for User
# Last modified on: 2015-04-21

class User < ActiveRecord::Base
	
	has_secure_password
	
	has_many :members
	has_many :organizations, :through => :members
	
	has_many :passengers
	has_many :rides, :through => :passengers
end
