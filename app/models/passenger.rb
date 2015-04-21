# Name: Ben Meyer
# Course: CSC 415
# Semester: Spring 2015
# Instructor: Dr. Pulimood 
# Project name: CooRIDEinate
# Description: Allows for members of an organization to coordinate rides to a common place
# Filename: passenger.rb 
# Description: Defines relations for Passenger
# Last modified on: 2015-04-21

class Passenger < ActiveRecord::Base
	
	belongs_to :user
	belongs_to :ride
	
end
