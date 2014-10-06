class SessionsController < ApplicationController

	def dashboard
		if session[:user_id]
			@current_user =  User.find session[:user_id]
			@user_projects = Project.where("user_id = ?",@current_user.id)
			@current_projects = @user_projects.where("finished = ?", false)
			@finished_projects = @user_projects.where("finished = ?", true)
			@current_shifts = Shift.joins(:project).where(projects: { user_id: @current_user.id})
			render "dashboard"
		else
			redirect_to :action => 'login'
		end
	end

	def profile
		if session[:user_id]
			@current_user =  User.find session[:user_id]
		else
			redirect_to :action => 'login'
		end
	end

	def statistics
		if session[:user_id]
			@current_user =  User.find session[:user_id]
			@total_shifts = Shift.joins(:project).where(projects: { user_id: @current_user.id})
			@total_hours = @total_shifts.sum(:duration)
			@hours_day = @total_hours / (( Time.now.to_date - @current_user.created_at.to_date ).to_i + 1)
		else
			redirect_to :action => 'login'
		end
	end

	def login
		#login form
	end

	def login_attempt
		authorized_user = User.authenticate(params[:name_or_email],params[:login_password])
		if authorized_user
			session[:user_id] = authorized_user.id
			flash[:notice] = "Welcome, you are now logged in as #{authorized_user.name}"
			redirect_to :action => 'dashboard'
		else
			flash[:notice] = "Invalid User name or Password"
			flash[:color] = "invalid"
			render "login"
		end
	end

	def login_auth
		auth = request.env["omniauth.auth"]
		user = User.find_by_provider_and_uid(auth["provider"],auth["uid"]) || User.create_with_omniauth(auth)
		session[:user_id] = user.id
		redirect_to :action => 'dashboard'
	end

	def logout
		session[:user_id] = nil
		redirect_to :action => 'login'
	end

	def home
		if session[:user_id] 
			@current_user = User.find session[:user_id]
		end
	end

end
