Feature: Returning user can login

Background: 

	Given the user "mike" exists with email "mike@gmail.com" and password "secret"
	And I am on the home page

Scenario: User login with name
	
	When I follow "Login"
	And I fill in "Name or email" with "mike"
	And I fill in "Password" with "secret"
	And I press "Log In"
	Then I should be on the dashboard
	And I should see "Welcome, you are now logged in as mike"