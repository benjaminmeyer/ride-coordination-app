class OrganizationsController < ApplicationController
  
	#layout false
	
	before_action :confirm_logged_in
	
	def index
		user = User.find(session[:user_id])
		#@organizations = Organization.all.active
		@organizations = user.organizations
	end
	
	def view
		@organization = Organization.find(params[:id])
		#@events = Event.where(:organization_id => @organization.id)
		@events = @organization.events
	end
end
