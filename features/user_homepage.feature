Feature: user homepage stats
  
  As a game player
  So that I can track my overall progress
  I would like to see game statistics on my account homepage
  
Scenario: Logged in loking for stats
  Given the following user is in the database: Jordan 123
  And I am on the users/1 page
  Then I should see "Your games:"
  And I should see "Play"