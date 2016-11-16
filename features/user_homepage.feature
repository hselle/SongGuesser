Feature: user homepage stats
  
  As a game player
  So that I can track my overall progress
  I would like to see various types of game statistics on my account homepage
  
Scenario: Logged in looking for games log
  Given the following user is in the database: Jordan 123
  And I am on the users/1 page
  Then I should see "Questions guessed correctly"
  
Scenario: Logged in looking for games log
  Given the following user is in the database: Jordan 123
  And I am on the users/1 page
  Then I should see "Questions guessed incorrectly"
  
Scenario: logged in and ready to play
  Given the following user is in the database: Jordan 123
  And I am on the users/1 page
  Then I should see "Play"
  