# Declarative step to create a user

Given /the user "(.*)" exists with email "(.*)" and password "(.*)"/ do |name,email,password|
	User.create!(:name => name,:email => email, :password => password, :password_confirmation => password, :provider => "Registered" )
end
