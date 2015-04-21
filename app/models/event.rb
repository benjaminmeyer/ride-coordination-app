# Name: Ben Meyer
# Course: CSC 415
# Semester: Spring 2015
# Instructor: Dr. Pulimood 
# Project name: CooRIDEinate
# Description: Allows for members of an organization to coordinate rides to a common place
# Filename: event.rb 
# Description: Defines relations for Event
# Last modified on: 2015-04-21

class Event < ActiveRecord::Base
	
	belongs_to :organization
	has_many :rides
	
	scope :eventActive, lambda {where(:events.deleted => 0)}
	
end
