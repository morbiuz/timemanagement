require 'rails_helper'


RSpec.describe Project, :type => :model do
	it "should have a valid factory" do
		expect(FactoryGirl.build(:project)).to be_valid
	end
	it "should require a name" do
		expect(FactoryGirl.build(:project, :name => "")).not_to be_valid
	end

	it "should return total time spent in seconds" do
		project = FactoryGirl.create(:project)
		FactoryGirl.create(:shift, :project_id => project.id)
		expect(project.total_time).to eq(600)
	end

	it "should return zero time if no shifts added" do
		project = FactoryGirl.create(:project)
		expect(project.total_time).to eq(0)
	end

	it "should return total time spent in text" do
		project = FactoryGirl.create(:project)
		FactoryGirl.create(:shift, :project_id => project.id)
		expect(project.total_time_textual).to eq("10 minutes ")
	end

	it "should return none if no shifts added" do
		project = FactoryGirl.create(:project)
		expect(project.total_time_textual).to eq("none")
	end

end
