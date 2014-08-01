class ProjectsController < ApplicationController
	
	def new
		@project = Project.new
		@current_user =  User.find session[:user_id]
	end

	def create
		@current_user =  User.find session[:user_id]
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

	def delete
		
	end
end
