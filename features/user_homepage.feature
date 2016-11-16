Feature: user homepage stats
  
  As a game player
  So that I can track my overall progress
  I would like to see various types of game statistics on my account homepage
  
Scenario: Logged in looking for games log
  Given the following user is in the database: Jordan 123
  And I am on the users/1 page
  Then I should see "Your games:"
  
  
Scenario: logged in looking for personal ranking
  Given the following user is in the database: Jordan 123
  And I am on the users/1 page
  Then I should see "Ranking"
  
  
Scenario: logged in and ready to play
  Given the following user is in the database: Jordan 123
  And I am on the users/1 page
  Then I should see "Play"
  
Scenario: no games to show
  Given: the following user is in the database: Jordan 123
  And I am on the users/1 page
  When I want to see my games
  But there are no stats to show
  Then I should see "No games currently available"
  
Scenario: no ranking to show
  Given: the following user is in the database: Jordan 123
  And I am on the users/1 page
  When I want to see my ranking
  But there is no ranking to show
  Then I should see "No ranking currently available"