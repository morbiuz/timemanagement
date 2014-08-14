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

	def update
		@shift = Shift.find(params[:id])
		@project = Project.find(@shift.project_id)
		if @shift.update(params[:shift].permit!)
			redirect_to "/users/#{@project.user_id}/projects/#{@project.id}/shifts"
		else
			render 'edit'
		end
	end

	def edit
		@project = Project.find params[:project_id]
		@user = User.find params[:user_id]
		@shift = Shift.find(params[:id])
	end

	def check_user
		#check that user in session is the same as user in url
		if session[:user_id].to_i == params[:user_id].to_i
			return true
		elsif session[:user_id]
			redirect_to(:controller => 'sessions' , :action => 'dashboard')
			return false
		else
			redirect_to(:controller => 'sessions' , :action => 'login')
			return false
		end
	end

	rescue_from ActiveRecord::RecordNotFound do
		flash[:notice] = 'The object you tried to access does not exist'
		redirect_to dashboard_path
	end
end
