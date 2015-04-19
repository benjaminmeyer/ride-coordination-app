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
		
		#check if user has access to event
		user = @organization.users.find_by_id(session[:user_id])
		
		#redirect user if they don't have access
		if !user
			flash[:notice] = "Organization not found"
			redirect_to(:controller => 'access', :action =>'notfound')
		end
	end
	
	def new
		
	end
	
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
	
	def join
		@organizations = Organization.all
	end
	
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
