class AccessController < ApplicationController
	def index
	end

	def login
	end
	
	def attempt_login
		if params[:email].present? && params[:password].present?
			found_user = User.where(:email => params[:email]).first
			
			if found_user
				authorized_user = found_user.authenticate(params[:password])
			end
		end
		
		if authorized_user
			redirect_to(:controller => 'dashboard')
		else
			flash[:notice] = "Invalid username or password"
			redirect_to(:action => 'login')
		end
			
	end
	
	def logout
		flash[:notice] = "Logged out"
		redirect_to(:action => 'login')
	end
end
