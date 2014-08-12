class ProjectsController < ApplicationController
	
	before_filter :check_user, :only => [:show, :new, :create, :destroy]

	def new
		@project = Project.new
		@current_user =  User.find session[:user_id]
	end

	def create
		@project = Project.new(params[:project].permit(:name, :description, :user_id))
		if @project.save
			flash[:notice] = "Project #{@project.name} created successfully."
			flash[:color] = "valid"
			redirect_to "/dashboard"
		else
			flash[:notice] = "Invalid project data"
			flash[:color] = "invalid"
			render "new"
		end

	end	

	def show
		@project = Project.find(params[:id])
	end

	def destroy
		@project_name = Project.find(params[:id]).name
		Project.destroy(params[:id])
		flash[:notice] = "Project #{@project_name} was deleted successfully."
		flash[:color] = "valid"
		redirect_to "/dashboard"
	end

	def check_user
		#check that user in session is the same as user in url
		if session[:user_id].to_i == params[:user_id].to_i
			return true
		else
			redirect_to(:controller => 'sessions' , :action => 'login')
			return false
		end
	end
end
