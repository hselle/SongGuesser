Feature: game play multiple choice selection
  
  As a music lover seeking a challenge
  So that I can test my ability to guess a song title
  I want to be able to choose an answer from a multiple choice list
 
 Given I am on the game play page
 
Scenario: I select an answer
    Given I am on the users page 
    And I enter the following username: Jordan 
    And I enter the following password: 123
    When I press "register" 
    Then I should be on the users/1 page
    When I follow "practice"
    Then I should be on the games page
    When I choose "artist2"
    And I press "submit"
    Then I should be on the games page
    And I should see either "WRONG" or "RIGHT"
   