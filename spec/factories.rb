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
	end
	factory :shift do
		project
		start_date Time.now - 10.minutes
		end_date Time.now
	end
end
