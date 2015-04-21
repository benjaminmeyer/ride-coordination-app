# Name: Ben Meyer
# Course: CSC 415
# Semester: Spring 2015
# Instructor: Dr. Pulimood 
# Project name: CooRIDEinate
# Description: Allows for members of an organization to coordinate rides to a common place
# Filename: profile_controller.rb 
# Description: Allows user to view their profile and edit their car
# Last modified on: 2015-04-21

class ProfileController < ApplicationController
	
	before_action :confirm_logged_in
	
	def index
		@user = User.find(session[:user_id])
	end
	
	def updatecar
		user = User.find(session[:user_id])
		
		user.car_passengers = params[:passengers].to_i
		
		if user.save
			flash[:notice] = "Number of passengers updated."
			redirect_to(:controller => 'profile') and return
		else
			flash[:notice] = "An error occured."
			redirect_to(:controller => 'profile') and return
		end
	end
end
