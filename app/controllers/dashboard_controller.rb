# Name: Ben Meyer
# Course: CSC 415
# Semester: Spring 2015
# Instructor: Dr. Pulimood 
# Project name: CooRIDEinate
# Description: Allows for members of an organization to coordinate rides to a common place
# Filename: dashboard_controller.rb 
# Description: Shows organizations and events on dashboard
# Last modified on: 2015-04-21

class DashboardController < ApplicationController
	
	before_action :confirm_logged_in
	
	#-----------------------------------------------------------------------------------------
	#  def index
	#    
	#    Pre-condition: User must be logged in with valid user id
	#    Post-condition: Organizations and Events for a user are returned from the database 
	#-----------------------------------------------------------------------------------------
	def index
		
		user = User.find(session[:user_id])
		
		@organizations = user.organizations
		@events = @organizations.flat_map(&:events)
		
		#@organizations = Organization.all
		#@events = Event.all
	end
	
end
