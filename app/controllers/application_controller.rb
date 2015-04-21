# Name: Ben Meyer
# Course: CSC 415
# Semester: Spring 2015
# Instructor: Dr. Pulimood 
# Project name: CooRIDEinate
# Description: Allows for members of an organization to coordinate rides to a common place
# Filename: application_controller.rb 
# Description: Confirms presence of logged-in user
# Last modified on: 2015-04-21

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	#protect_from_forgery with: :null_session
	
	private
	
	def confirm_logged_in
		unless session[:user_id]
			flash[:notice] = "Please Log In"
			redirect_to(:controller => 'access', :action =>'login')
			return false
		else
			return true
		end
	end
	
end
