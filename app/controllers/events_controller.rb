# Name: Ben Meyer
# Course: CSC 415
# Semester: Spring 2015
# Instructor: Dr. Pulimood 
# Project name: CooRIDEinate
# Description: Allows for members of an organization to coordinate rides to a common place
# Filename: events_controller.rb 
# Description: Allows user to view, create, and signup for events
# Last modified on: 2015-04-21

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
	
	def new
		#redirect if no organization specified - need to check if org is in database
		if !params[:id]
			redirect_to(:controller => 'events')
		end
	end
	
	def create
		#check if user has access to organization
		@organization = Organization.find(params[:id])
		user = @organization.users.find_by_id(session[:user_id])
		
		#redirect user if they don't have access
		if !user
			flash[:notice] = "Event not found"
			redirect_to(:controller => 'access', :action =>'notfound')
		end
		
		#verify values
		if !params[:name].present?
			flash[:notice] = "Must enter a name for the event"
			redirect_to(:action =>'new', :id => params[:id], :name => params[:name], :address => params[:address], :date => params[:date],
				:start_hour => params[:start_hour], :start_min => params[:start_min], :start_ampm => params[:start_ampm],
				:end_hour => params[:end_hour], :end_min => params[:end_min], :end_ampm => params[:end_ampm]) and return
		end
		
		if !params[:address].present?
			flash[:notice] = "Must enter an address for the event"
			redirect_to(:action =>'new', :id => params[:id], :name => params[:name], :address => params[:address], :date => params[:date],
				:start_hour => params[:start_hour], :start_min => params[:start_min], :start_ampm => params[:start_ampm],
				:end_hour => params[:end_hour], :end_min => params[:end_min], :end_ampm => params[:end_ampm]) and return
		end
		
		if !params[:date].present?
			flash[:notice] = "Must enter an date for the event"
			redirect_to(:action =>'new', :id => params[:id], :name => params[:name], :address => params[:address], :date => params[:date],
				:start_hour => params[:start_hour], :start_min => params[:start_min], :start_ampm => params[:start_ampm],
				:end_hour => params[:end_hour], :end_min => params[:end_min], :end_ampm => params[:end_ampm]) and return
		end
		
		if !params[:start_hour].present? || !params[:start_min].present? || !params[:start_ampm].present?
			flash[:notice] = "Must enter a valid start time for the event"
			redirect_to(:action =>'new', :id => params[:id], :name => params[:name], :address => params[:address], :date => params[:date],
				:start_hour => params[:start_hour], :start_min => params[:start_min], :start_ampm => params[:start_ampm],
				:end_hour => params[:end_hour], :end_min => params[:end_min], :end_ampm => params[:end_ampm]) and return
		end
		
		if !params[:end_hour].present? || !params[:end_min].present? || !params[:end_ampm].present?
			flash[:notice] = "Must enter a valid end time for the event"
			redirect_to(:action =>'new', :id => params[:id], :name => params[:name], :address => params[:address], :date => params[:date],
				:start_hour => params[:start_hour], :start_min => params[:start_min], :start_ampm => params[:start_ampm],
				:end_hour => params[:end_hour], :end_min => params[:end_min], :end_ampm => params[:end_ampm]) and return
		end
		
		#create event
		newevent = Event.new
			
		newevent.organization = @organization
		newevent.name = params[:name]
		newevent.address = params[:address]
		newevent.date = params[:date]
		
		#start time format
		if params[:start_ampm] == 'pm'
			starthour = params[:start_hour].to_i + 12
		else
			starthour = params[:start_hour]
		end
			
		newevent.start_time = starthour.to_s + ":" + params[:start_min].to_s + ":00" 
		
		#end time format
		if params[:end_ampm] == 'pm'
			endhour = params[:end_hour].to_i + 12
			if endhour == 24
				endhour = 00
			end
		else
			endhour = params[:end_hour]
		end
			
		newevent.end_time = endhour.to_s + ":" + params[:end_min].to_s + ":00"
		
		#save event
		if newevent.save
			redirect_to(:controller => 'events', :action =>'view', :id => newevent.id)
		else
			redirect_to(:controller => 'organizations', :action =>'view', :id => params[:id])
		end
	end
	
	def drive
		
		#check if user has access to event
		@event = Event.find(params[:id])
		@organization = @event.organization
		@user = @organization.users.find_by_id(session[:user_id])
		
		#reidrect if no event specified - need to check if event is in database
		if !params[:id]
			redirect_to(:controller => 'events')
		end
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
		
		if !params[:num_passengers].present?
			flash[:notice] = "Must enter number of passengers."
			redirect_to(:action => 'drive', :id => params[:id]) and return
		else
			
			#create ride
			ride = Ride.new(params.require(:ride).permit(:notes))

			ride.event = @event
			
			ride.num_passengers = params[:num_passengers]

			if ride.save

				#create driver and assign to organization
				driver = Passenger.new
				driver.ride = ride
				driver.user = user
				driver.role = "driver"

				if driver.save
					flash[:notice] = "You have been signed up to drive."
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
				flash[:notice] = "You have been signed up."
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
	
	def autosignup
		#check if user has access to event
		@event = Event.find(params[:id])
		@organization = @event.organization
		user = @organization.users.find_by_id(session[:user_id])
		
		#redirect user if they don't have access
		if !user
			flash[:notice] = "Event not found"
			redirect_to(:controller => 'access', :action =>'notfound')
		end
		
		#check if there are existing rides for event
		@rides = @event.rides
		
		if !@rides.present?
			flash[:notice] = "No rides found. Please be a driver if you have a car."
			redirect_to(:action => 'drive', :id => params[:id]) and return
			
		else
			#find ride
			ride = @event.rides.first
		
			#create passenger and assign to ride
			passenger = Passenger.new
			passenger.ride = ride
			passenger.user = user
			passenger.role = "passenger"

			if passenger.save
				flash[:notice] = "You have been signed up as a passenger."
				redirect_to(:action => 'view', :id => params[:id])
			else
				flash[:notice] = "Error occured."
				redirect_to(:action => 'view', :id => params[:id])
			end
		end
	end
end
