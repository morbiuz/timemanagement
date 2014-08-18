require 'rails_helper'

RSpec.describe ShiftsController, :type => :controller do
	before(:each) do
    	@user = FactoryGirl.create(:user)
    	@project = FactoryGirl.create(:project,:user_id => @user.id)
    	@shift = FactoryGirl.create(:shift,:project_id => @project.id)
    	session[:user_id] = @user.id
  	end

	describe 'New shift' do
		it 'should render the correct template' do
			get :new, user_id: @user.id, project_id: @project.id
	    	expect(response).to render_template 'new'
	    end
	    it 'should redirect to login if user is not logged in' do
	    	session[:user_id] = nil
	    	get :new, user_id: @user.id, project_id: @project.id
	    	expect(response).to redirect_to login_path
	    end
	    it 'should redirect to dashboard if user tries to access other users project' do
	    	get :new, user_id: (@user.id+1), project_id: (@project.id+1)
	    	expect(response).to redirect_to dashboard_path
	    end
	    it 'should redirect to dashboard if user tries to access a non existent project' do
	    	get :new, user_id: (@user.id), project_id: (@project.id+1)
	    	expect(response).to redirect_to dashboard_path
	    end
	end

	describe 'Create shift' do
		it 'should create a shift' do
			shift_params = FactoryGirl.attributes_for(:shift, :project_id => @project.id)
			expect { post :create, user_id: @user.id, project_id: @project.id, :shift => shift_params}.to change(Shift, :count).by(1)
		end
		it 'should redirect to the project page' do
			shift_params = FactoryGirl.attributes_for(:shift, :project_id => @project.id)
			post :create, user_id: @user.id, project_id: @project.id, :shift => shift_params
			expect(response).to redirect_to "/users/#{@user.id}/projects/#{@project.id}"
		end
		it 'should not create if data is invalid' do
			shift_params = FactoryGirl.attributes_for(:invalid_shift, :project_id => @project.id)
			expect { post :create, user_id: @user.id, project_id: @project.id, :shift => shift_params}.not_to change(Shift, :count)
		end
		it 're-renders the new method if data is invalid' do
			shift_params = FactoryGirl.attributes_for(:invalid_shift, :project_id => @project.id)
			post :create, user_id: @user.id, project_id: @project.id, :shift => shift_params
			expect(response).to render_template 'new'
		end
	end

	describe 'Destroy shift' do
		it 'deletes the shift' do
			expect{ delete :destroy, user_id: @user.id, project_id: @project.id, id: @shift }.to change(Shift,:count).by(-1)
		end
		it 'redirects back to project shifts' do
			delete :destroy, user_id: @user.id, project_id: @project.id, id: @shift
			expect(response).to redirect_to "/users/#{@user.id}/projects/#{@project.id}/shifts"
		end
	end

	# Show shift is not necessary so its ommited

	describe 'Edit shift' do
		it 'locates the requested @shift' do
			put :update, user_id: @user.id, project_id: @project.id, id: @shift, shift: FactoryGirl.attributes_for(:shift,project_id: @project.id)
			expect(assigns(:shift)).to eq(@shift)
		end
		it 'changes @shift\'s attributes' do
			time = Time.parse("01/01/2014 10:00")
			put :update, user_id: @user.id, project_id: @project.id, id: @shift,shift: FactoryGirl.attributes_for(:shift,start_date: time, project_id: @project.id)
			@shift.reload
			expect(@shift.start_date).to eq(time)
		end
		it 'redirects to the updated shifts list' do
			put :update, user_id: @user.id, project_id: @project.id, id: @shift, shift: FactoryGirl.attributes_for(:shift,project_id: @project.id)
			expect(response).to redirect_to "/users/#{@user.id}/projects/#{@project.id}/shifts"
		end
	end
end