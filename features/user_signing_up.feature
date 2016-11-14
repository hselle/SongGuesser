Feature: intial account creation or login to play the game
  
  As a first time game player (without a SoundCloud account)
  So that I can play the game
  I would like to create an account by entering a new username and password
  
Given I am on the welcome page

Scenario: register a username
  Given I am on the users page
  When I enter the following username: Jordan
  And I enter the following password: pass
  And I press "register"
  Then I should be on the users/1 page

Scenario: username is already in database (sad path)
  Given I am on the users page
  And the following user is in the database: Jordan pass
  When I enter the following username: Jordan
  And I press "register"
  Then I should be on the users page
  And I should see "Username already exists"
  

Scenario: login with existing username and password
  Given I am on the users page
  And the following user is in the database: Jordan pass
  When I log in with the following user: Jordan pass
  And I press "login"
  Then I should be on the users/1 page
  And I should see "Hello, Jordan"
  
Scenario: typo when logging in with password
  Given I am on the users page
  And the following user is in the database: Jordan pass
  When I log in with the following user: Jordan invalidPass
  And I press "login"
  Then I should be on the users page
  And I should see "Invalid username or password"
  
Scenario: typo when logging in with username
  Given I am on the users page
  And the following user is in the database: Jordan pass
  When I log in with the following user: Steve pass
  And I press "login"
  Then I should be on the users page
  And I should see "Invalid username or password"
  
#Scenario: no username and password entered (super sad path)
#When I don't type a username
# And I don't type a password
#  Then I am prompted to enter a username and password
