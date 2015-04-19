class EventsController < ApplicationController
	
	before_action :confirm_logged_in
	
	def index
		user = User.find(session[:user_id])
		organizations = user.organizations
		@events = organizations.flat_map(&:events)
	end
	
	def view
		@event = Event.find(params[:id])
		
		@rides = @event.rides.joins(:users).uniq
		
		#@users = @rides.flat_map(&:users)
		
		#check if user has access to event
		@organization = @event.organization
		user = @organization.users.find_by_id(session[:user_id])
		
		#redirect user if they don't have access
		if !user
			flash[:notice] = "Event not found"
			redirect_to(:controller => 'access', :action =>'notfound')
		end
	end
	
	def drive
		
	end
	
	def makeride
		#check if user has access to event
		@event = Event.find(params[:id])
		@organization = @event.organization
		user = @organization.users.find_by_id(session[:user_id])
		
		#redirect user if they don't have access
		if !user
			flash[:notice] = "Event not found"
			redirect_to(:controller => 'access', :action =>'notfound')
		end
		
		#create ride
		ride = Ride.new(params.require(:ride).permit(:num_passengers, :notes))
		
		ride.event = @event
		
		if ride.save
			
			#create driver and assign to organization
			driver = Passenger.new
			driver.ride = ride
			driver.user = user
			driver.role = "driver"
			
			if driver.save
				flash[:notice] = "You are signed up to drive."
				redirect_to(:action => 'view', :id => params[:id])
			else
				flash[:notice] = "Error occured."
				redirect_to(:action => 'view', :id => params[:id])
			end
		else
			flash[:notice] = "Error occured."
			redirect_to(:action => 'view', :id => params[:id])
		end
	end
	
	def signup
		#check if user has access to event
		@event = Event.find(params[:id])
		@organization = @event.organization
		user = @organization.users.find_by_id(session[:user_id])
		
		#redirect user if they don't have access
		if !user
			flash[:notice] = "Event not found"
			redirect_to(:controller => 'access', :action =>'notfound')
		end
		
		# check if params exist
		if params[:car]
			#get ride
			ride = Ride.find(params[:car])
		
			#create passenger and assign to ride
			passenger = Passenger.new
			passenger.ride = ride
			passenger.user = user
			passenger.role = "passenger"

			if passenger.save
				flash[:notice] = "You are signed up."
				redirect_to(:action => 'view', :id => params[:id])
			else
				flash[:notice] = "Error occured."
				redirect_to(:action => 'view', :id => params[:id])
			end
		else
			flash[:notice] = "Error occured."
			redirect_to(:action => 'view', :id => params[:id])
		end
	end
end
