class OrganizationsController < ApplicationController
  
	#layout false
	
	def index
		@organizations = Organization.all.active
	end
	
	def view
	end
end
