class UsersController < ApplicationController

	before_filter :save_login_state, :only => [:new, :create]
	
	def index
		redirect_to login_path
	end
	
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user].permit(:name, :email, :password, :password_confirmation, :provider))
		if @user.save
			flash[:notice] = "You signed up successfully."
			flash[:color] = "valid"
			session[:user_id] = @user.id
			redirect_to "/dashboard"
		else
			flash[:notice] = "Form is invalid"
			flash[:color] = "invalid"
			render "new"
		end

	end	

end
