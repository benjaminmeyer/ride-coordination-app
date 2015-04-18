class EventsController < ApplicationController
	
	before_action :confirm_logged_in
	
	def index
		user = User.find(session[:user_id])
		organizations = user.organizations
		@events = organizations.flat_map(&:events)
	end
	
	def view
		@event = Event.find(params[:id])
	end
end
