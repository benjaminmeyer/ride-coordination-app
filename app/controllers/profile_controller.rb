class ProfileController < ApplicationController
	
	before_action :confirm_logged_in
	
	def index
		@user = User.find(session[:user_id])
	end
	
	def updatecar
		user = User.find(session[:user_id])
		
		user.car_passengers = params[:passengers].to_i
		
		if user.save
			flash[:notice] = "Number of passengers updated."
			redirect_to(:controller => 'profile') and return
		else
			flash[:notice] = "An error occured."
			redirect_to(:controller => 'profile') and return
		end
	end
end
