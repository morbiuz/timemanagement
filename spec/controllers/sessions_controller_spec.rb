require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
	before(:each) do
    	@user = FactoryGirl.create(:user)
  	end  

	describe 'Dashboard' do
	    it 'should redirect to login if no user is logged in' do
			get :dashboard
	    	expect(response).to redirect_to login_path
	    end
		it 'should render the correct view if logged in' do
			session[:user_id] = @user.id
			get :dashboard
			expect(response).to render_template 'dashboard'
		end
	end

	describe 'Login' do
		it 'should render the correct view' do
			get :login
			expect(response).to render_template 'login'
		end
		it 'should redirect to dashboard if already logged in' do
			session[:user_id] = @user.id
			get :login
			expect(response).to redirect_to dashboard_path
		end
	end

	describe 'Home' do
		it 'should render the correct view' do
			get :home
			expect(response).to render_template 'home'
		end
	end

	describe 'Logout' do
		it 'should redirect to login' do
			get :logout
			expect(response).to redirect_to login_path
		end
	end
end