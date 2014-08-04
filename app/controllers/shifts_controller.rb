class ShiftsController < ApplicationController

	before_filter :check_user, :only => [:show, :new, :create, :destroy]

	def index
		@project = Project.find params[:project_id]
		@shifts = Shift.where('project_id = ?',@project.id)
	end

	def new
		@project = Project.find params[:project_id]
		@shift = Shift.new
	end

	def create
		@project = Project.find params[:project_id]
		@user = User.find params[:user_id]
		#used params[:shift].permit! so the full Shift hash is permitted, since datetime variables create sub-hashes
		@shift = Shift.new(params[:shift].permit!) 
		if @shift.save
			flash[:notice] = "Shift added successfully."
			flash[:color] = "valid"
			redirect_to "/users/#{@user.id}/projects/#{@project.id}"
		else
			flash[:notice] = "Invalid shift data"
			flash[:color] = "invalid"
			render "new"
		end
	end	

	def destroy
		@project = Project.find params[:project_id]
		@user = User.find params[:user_id]
		Shift.destroy(params[:id])
		flash[:notice] = "Shift deleted successfully."
		flash[:color] = "valid"
		redirect_to "/users/#{@user.id}/projects/#{@project.id}/shifts"
	end

	def check_user
		#check that user in session is the same as user in url
		if session[:user_id].to_i == params[:user_id].to_i
			return true
		else
			redirect_to(:controller => 'sessions' , :action => 'dashboard')
			return false
		end
	end


	
end
