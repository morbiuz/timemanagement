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
	factory :shift do
		project
		start_date Time.now - 10.minutes
		end_date Time.now
	end
end
