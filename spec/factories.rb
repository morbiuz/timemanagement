FactoryGirl.define do 
	factory :user do
		name "Mario"
		email "mario@gmail.com"
		password "whatever"
		password_confirmation "whatever"
		provider "registered"
	end
end
