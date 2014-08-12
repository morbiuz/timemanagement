require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
	before(:each) do
    	@user = FactoryGirl.create(:user)
  	end  

	describe 'Register a new user' do
	    it 'should render the correct template' do
			get :new
	    	expect(response).to render_template('new')
	    end
	end

	describe 'Get #index' do
		it 'should redirect to home' do
			get :index
			expect(response).to redirect_to login_path
		end
	end	
end