class DashboardController < ApplicationController
	
	before_action :confirm_logged_in
	
	def index
		
		user = User.find(session[:user_id])
		
		@organizations = user.organizations
		@events = @organizations.flat_map(&:events)
		
		#@organizations = Organization.all
		#@events = Event.all
	end
	
end
