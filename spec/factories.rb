FactoryGirl.define do 
	factory :user do
		name "Mario"
		email "mario@gmail.com"
		password "whatever"
		password_confirmation "whatever"
		provider "registered"
	end
	factory :project do
		user
		name "Awesome Project"
		description "This is an awesome project description"
	end
	factory :invalid_project, parent: :project do
		user
		name ""
		description "This is an awesome project description"
	end
	factory :shift do
		project
		start_date Time.now - 10.minutes
		end_date Time.now
	end
	factory :invalid_shift, parent: :shift do
		project
		start_date Time.now - 10.minutes
		end_date Time.now - 20.minutes
	end
end
