# Name: Ben Meyer
# Course: CSC 415
# Semester: Spring 2015
# Instructor: Dr. Pulimood 
# Project name: CooRIDEinate
# Description: Allows for members of an organization to coordinate rides to a common place
# Filename: ride.rb 
# Description: Defines relations for Ride
# Last modified on: 2015-04-21

class Ride < ActiveRecord::Base
	
	belongs_to :event
	
	has_many :passengers
	has_many :users, :through => :passengers
	
end
