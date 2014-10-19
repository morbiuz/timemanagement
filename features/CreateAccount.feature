Feature: User can create a new account

Scenario: Create a movie
	Given I am on the home page
	When I follow "Register"
	Then I should be on the Create new user page
	When I fill in "Name" with "Mike"
	And I fill in "Email" with "mike@gmail.com"
	And I fill in "Password" with "secret"
	And I fill in "Password confirmation" with "secret"
	And I press "Sign up"
	Then I should be on the dashboard
	And I should see "You signed up successfully" 
	And I should see "This is your dashboard"
