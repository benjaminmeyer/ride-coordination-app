# Name: Ben Meyer
# Course: CSC 415
# Semester: Spring 2015
# Instructor: Dr. Pulimood 
# Project name: CooRIDEinate
# Description: Allows for members of an organization to coordinate rides to a common place
# Filename: access_controller.rb 
# Description: Allows user to login and signup
# Last modified on: 2015-04-21

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
			session[:user_id] = authorized_user.id
			session[:first_name] = authorized_user.first_name
			redirect_to(:controller => 'dashboard')
		else
			flash[:notice] = "Invalid username or password"
			redirect_to(:action => 'login')
		end
			
	end
	
	def logout
		session[:user_id] = nil
		session[:first_name] = nil
		flash[:notice] = "Logged out"
		redirect_to(:action => 'login')
	end
	
	def notfound
		
	end
	
	def create
		
	end
	
	def createuser
		user = User.new
		
		founduser = User.find_by_email(params[:email])
		
		if !params[:first_name].present?
			flash[:notice] = "Must enter a first name."
			redirect_to(:action => 'create', :last => params[:last_name], :mail => params[:email]) and return
		else
			user.first_name = params[:first_name]
		end
		
		if !params[:last_name].present?
			flash[:notice] = "Must enter a last name."
			redirect_to(:action => 'create', :first => params[:first_name], :mail => params[:email]) and return
		else
			user.last_name = params[:last_name]
		end
		
		if !params[:email].present?
			flash[:notice] = "Must enter an email."
			redirect_to(:action => 'create', :first => params[:first_name], :last => params[:last_name]) and return
		end
		
		if founduser
			flash[:notice] = "That email has already been used."
			redirect_to(:controller => 'login') and return
		else
			user.email = params[:email]
		end
		
		if !params[:password].present? || !params[:verifypassword].present?
			flash[:notice] = "Must enter password."
			redirect_to(:action => 'create', :first => params[:first_name], :last => params[:last_name], :mail => params[:email]) and return
		else
			if params[:password] == params[:verifypassword]
				user.password = params[:password]
			else 
				flash[:notice] = "Passwords do not match."
				redirect_to(:action => 'create', :first => params[:first_name], :last => params[:last_name], :mail => params[:email]) and return
			end
		end
		
		if user.save
			session[:user_id] = user.id
			session[:first_name] = user.first_name
			flash[:notice] = "Welcome!"
			redirect_to(:controller => 'dashboard')
		else
			flash[:notice] = "Error occured"
			redirect_to(:controller => 'dashboard')
		end
		
	end
end
