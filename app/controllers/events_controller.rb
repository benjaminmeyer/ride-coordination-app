class EventsController < ApplicationController
	
	before_action :confirm_logged_in
	
	def index
		user = User.find(session[:user_id])
		organizations = user.organizations
		@events = organizations.flat_map(&:events)
	end
	
	def view
		@event = Event.find(params[:id])
		
		@rides = @event.rides
		
		@users = @rides.flat_map(&:users)
		
		#check if user has access to event
		@organization = @event.organization
		user = @organization.users.find_by_id(session[:user_id])
		
		#redirect user if they don't have access
		if !user
			flash[:notice] = "Event not found"
			redirect_to(:controller => 'access', :action =>'notfound')
		end
	end
end
