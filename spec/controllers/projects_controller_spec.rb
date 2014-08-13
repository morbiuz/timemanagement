require 'rails_helper'

# Rails.application.routes.draw do
#   match "/logout" => "sessions#logout", :as => "logout", :via => "get"
# end

RSpec.describe ProjectsController, :type => :controller do
	before(:each) do
    	@user = FactoryGirl.create(:user)
    	@project = FactoryGirl.create(:project,:user_id => 1)
    	session[:user_id] = @user.id
  	end  

	describe 'New project' do
	    it 'should render the correct template' do
			get :new, user_id: @user.id
	    	expect(response).to render_template 'new'
	    end
	    it 'should redirect to login if user is not logged in' do
	    	session[:user_id] = nil
	    	get :new, user_id: @user.id
	    	expect(response).to redirect_to login_path
	    end
	    it 'should assign the proper user to @current_user' do
	    	get :new, user_id: @user.id
	    	expect(assigns(:current_user)).to eq(@user)
	    end
	end

	describe 'Create project' do
		it 'should create a project' do
			project_params = FactoryGirl.attributes_for(:project, :user_id => @user.id)
			expect { post :create, user_id: @user.id, :project => project_params}.to change(Project, :count).by(1)
		end
		it 'should redirect to the new project' do
			project_params = FactoryGirl.attributes_for(:project, :user_id => @user.id)
			post :create, user_id: @user.id, :project => project_params
			expect(response).to redirect_to "/users/#{@user.id}/projects/#{Project.last.id}"
		end
		it 'should not create if data is invalid' do
			project_params = FactoryGirl.attributes_for(:invalid_project, :user_id => @user.id)
			expect { post :create, user_id: @user.id, :project => project_params}.not_to change(Project, :count)
		end
		it 're-renders the new method if data is invalid' do
			project_params = FactoryGirl.attributes_for(:invalid_project, :user_id => @user.id)
			post :create, user_id: @user.id, :project => project_params
			expect(response).to render_template 'new'
		end
	end

	describe 'Destroy project' do
		it 'deletes the project' do
			expect{ delete :destroy, user_id: @user.id, id: @project }.to change(Project,:count).by(-1)
		end
		it 'redirects back to dashboard' do
			delete :destroy, user_id: @user.id, id: @project
			expect(response).to redirect_to dashboard_path
		end
	end

	describe 'Show project' do
		it 'renders the correct template' do
			get :show, user_id: @user.id, id: @project
			expect(response).to render_template 'show'
		end
		it 'assigns the requested project to @project' do
			get :show, user_id: @user.id, id: @project
			expect(assigns(:project)).to eq(@project)
		end
	end

	describe 'Edit project' do
		it 'locates the requested @project' do
			put :update, user_id: @user.id, id: @project, project: FactoryGirl.attributes_for(:project,user_id: @user.id)
			expect(assigns(:project)).to eq(@project)
		end
		it 'changes @project\'s attributes' do
			put :update, user_id: @user.id, id: @project, project: FactoryGirl.attributes_for(:project,name: "Another project", user_id: @user.id)
			@project.reload
			expect(@project.name).to eq("Another project")
		end
		it 'redirects to the updated contact' do
			put :update, user_id: @user.id, id: @project, project: FactoryGirl.attributes_for(:project, user_id: @user.id)
			expect(response).to redirect_to "/users/#{@user.id}/projects/#{@project.id}"
		end
	end
end