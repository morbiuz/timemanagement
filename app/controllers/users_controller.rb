class UsersController < ApplicationController

	before_filter :save_login_state, :only => [:new, :create]
	
	def index
		@users = User.all
	end
	
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user].permit(:name, :email, :password, :password_confirmation))
		if @user.save
			flash[:notice] = "You signed up successfully"
			flash[:color] = "valid"
			redirect_to "/"
		else
			flash[:notice] = "Form is invalid"
			flash[:color] = "invalid"
			render "new"
		end

	end	

end
