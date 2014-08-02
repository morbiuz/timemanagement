class ShiftsController < ApplicationController

	def new
		@project = Project.find params[:project_id]
		@shift = Shift.new
	end

	def create
		@project = Project.find params[:project_id]
		@user = User.find params[:user_id]
		@shift = Shift.new(params[:shift].permit(:project_id,:start_date,:end_date))
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
end
