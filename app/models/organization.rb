# Name: Ben Meyer
# Course: CSC 415
# Semester: Spring 2015
# Instructor: Dr. Pulimood 
# Project name: CooRIDEinate
# Description: Allows for members of an organization to coordinate rides to a common place
# Filename: organization.rb 
# Description: Defines relations and valiations for Organization
# Last modified on: 2015-04-21

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
