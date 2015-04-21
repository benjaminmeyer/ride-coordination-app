# Name: Ben Meyer
# Course: CSC 415
# Semester: Spring 2015
# Instructor: Dr. Pulimood 
# Project name: CooRIDEinate
# Description: Allows for members of an organization to coordinate rides to a common place
# Filename: organizations_controller.rb 
# Description: Allows user to create, view, and join organizations
# Last modified on: 2015-04-21

class OrganizationsController < ApplicationController
  
	#layout false
	
	before_action :confirm_logged_in
	
	#-----------------------------------------------------------------------------------------
	#  def index
	#    
	#    Pre-condition: Valid logged in user id must be present
	#    Post-condition: Organizations for user are pulled from database 
	#-----------------------------------------------------------------------------------------
	def index
		user = User.find(session[:user_id])
		#@organizations = Organization.all.active
		@organizations = user.organizations
	end
	
	#-----------------------------------------------------------------------------------------
	#  def view
	#    
	#    Pre-condition: Valid organization id must be present
	#    Post-condition: Single organization is pulled from database 
	#-----------------------------------------------------------------------------------------
	def view
		@organization = Organization.find(params[:id])
		#@events = Event.where(:organization_id => @organization.id)
		@events = @organization.events
		
		#check if user has access to event
		user = @organization.users.find_by_id(session[:user_id])
		
		#redirect user if they don't have access
		if !user
			flash[:notice] = "Organization not found"
			redirect_to(:controller => 'access', :action =>'notfound')
		end
	end
	
	#-----------------------------------------------------------------------------------------
	#  def new
	#    
	#    Blank action. New organization form is displayed to user
	#-----------------------------------------------------------------------------------------
	def new
	end
	
	#-----------------------------------------------------------------------------------------
	#  def create
	#    
	#    Pre-condition: Valid logged in user id must be present
	#    Post-condition: Organization is created and saved in database. User is directed to
	#					organization page.
	#-----------------------------------------------------------------------------------------
	def create
		user = User.find(session[:user_id])
		
		@organization = Organization.new(params.require(:organization).permit(:name))
		
		#fill in defaults
		@organization.semester = "Spring"
		@organization.year = 2015
		
		if @organization.save
			
			#create member and assign to organization
			member = Member.new
			member.organization = @organization
			member.user = user
			member.role = "member"
			
			if member.save
				flash[:notice] = "Organization created."
				redirect_to(:action => 'view', :id => @organization.id)
			else
				redirect_to(:action => 'index')
			end
		else
			render('new')
		end
	end
	
	#-----------------------------------------------------------------------------------------
	#  def join
	#    
	#    Pre-condition: none
	#    Post-condition: A list of organizations is pulled from the database 
	#-----------------------------------------------------------------------------------------
	def join
		@organizations = Organization.all
	end
	
	#-----------------------------------------------------------------------------------------
	#  def dojoin
	#    
	#    Pre-condition: Valid logged-in user id must be present.
	#					Valid organization id must be present
	#    Post-condition: User is added to organization in database. 
	#					Directed to organization page
	#-----------------------------------------------------------------------------------------
	def dojoin
		member = Member.new
		
		member.user_id = session[:user_id]
		member.organization_id = params[:id]
		member.role = "member"
		
		if member.save
			flash[:notice] = "Added to organization."
			redirect_to(:action => 'view', :id => params[:id])
		else
			flash[:notice] = "Error."
			redirect_to(:action => 'join')
		end
	end
end
